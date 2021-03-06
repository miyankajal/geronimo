class User < ActiveRecord::Base

	#attr_accessor :password, :verify_password, :new_password
    before_save :email_downcase
	before_create :create_remember_token
    
	MAX_EMAIL = 64
	MAX_PASSWORD = 64
	MAX_USERNAME = 64
	MAX_FIRST_NAME = MAX_LAST_NAME = 64
	EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
	
	belongs_to :class_section
	belongs_to :user_type
	belongs_to :school
	
	has_many :student_points, dependent: :destroy
	has_many :points, through: :student_points
	
	has_many :teacher_class_relationships, dependent: :destroy
	has_many :class_sections, through: :teacher_class_relationships
	
	# self referential associations
	has_many :guardianships
    accepts_nested_attributes_for :guardianships
	has_many :guardians, :through => :guardianships
	has_many :inverse_guardianships, :class_name => "GuardianShip", :foreign_key => "guardian_id"
	has_many :inverse_guardians, :through => :inverse_guardianships, :source => :user
	
	has_many :comments
	has_many :ideas
	has_many :user_idea_relationships

    has_secure_password
	
    validates_presence_of :username, :password_digest, :first_name, :last_name, :unless => :is_invitation?
    validates_presence_of :email, :unless => :is_student?
	validates_presence_of :class_id, :if => :is_student? #should have a class_id and enrollment_id only if the user is a student 
	validates_presence_of :enrollment_id, :if => :is_student?
	validates_presence_of :school_id, :unless => :is_guardian?
	
	validates_format_of :email, 
						:with => EMAIL_REGEX, 
						:on => :create, 
						:message => "must be a valid email address", :unless => :is_student?
					
	
	validates_length_of :email, :within => 6..MAX_EMAIL, :unless => :is_student?
    validates_length_of :username, :maximum => MAX_USERNAME, :unless => :is_invitation?
    validates_length_of :first_name, :maximum => MAX_FIRST_NAME, :unless => :is_invitation?
    validates_length_of :last_name, :maximum => MAX_LAST_NAME, :unless => :is_invitation?
	
	validates_uniqueness_of :email, :case_sensitive => false, :unless => :is_student?
	validates_uniqueness_of :enrollment_id, :if => :is_student?
	
    validates_confirmation_of :password,
    						  if: lambda { |m| m.password.present? }, :unless => :is_invitation?
	
	self.inheritance_column = nil
	
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	
	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	def	send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset_email(self).deliver
	end
	
	def generate_token(column)
		begin 
			self[column] = SecureRandom.urlsafe_base64(20, false)
		end while User.exists?(column => self[column])
	end
    
    def self.accessible_attributes
        ['email', 'enrollment_id']
    end
    
    def self.import_from_file(file, school_id, user_type, class_id)
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            user = User.find_by_id(row["id"]) || new
            #(:username, :email, :first_name, :last_name, :enrollment_id
            user.attributes = row.to_hash.slice(*accessible_attributes)
            user.school_id = school_id
            user.type = user_type
            user.password = SecureRandom.hex(13)
            user.password_confirmation = user.password
            
            if user_type == '3'
                user.class_id = class_id
            end
            
            if user_type == '4'
                user.enrollment_id = 0
                ward_enrollment_ids = row["enrollment_id"].split(",")
            end
            
            unless user.save
                return false
            end
            
            if (@user.email?)
                UserMailer.welcome_email(@user).deliver
            end
            
            if user_type == '4'
                ward_enrollment_ids = Array.new
                ward_enrollment_ids.each do |enrollment_id|
                    user_id = User.select('id').where(:enrollment_id => enrollment_id).first
                    Guardianship.create!(:guardian_id => user.id, :user_id => user_id.id)
                end
            end
        end
        return true
    end
    
    def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
            when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
            when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
            when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
            else raise "Unknown file type: #{file.original_filename}"
        end
    end
    
    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << column_names
            all.each do |user|
                csv << user.attributes.values_at(*column_names)
            end
        end
    end

   	
	private
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end
		
		def is_student?
			self.type == 3
		end
		
		def is_guardian?
			self.type == 4
		end
        
        def email_downcase
            if self.email?
                self.email = email.downcase
            end
        end
        
        def is_invitation?
            !new_user_token.nil?
        end

end
