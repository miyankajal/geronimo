class User < ActiveRecord::Base

	#attr_accessor :password, :verify_password, :new_password
	before_save { self.email = email.downcase }
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
	has_many :guardians, :through => :guardianships
	has_many :inverse_guardianships, :class_name => "GuardianShip", :foreign_key => "guardian_id"
	has_many :inverse_guardians, :through => :inverse_guardianships, :source => :user
	
	has_many :comments
	has_many :ideas
	has_many :user_idea_relationships

	has_secure_password
	
	validates_presence_of :username, :password_digest, :first_name, :last_name
	validates_presence_of :email, :unless => :is_student?
	validates_presence_of :class_id, :if => :is_student? #should have a class_id and enrollment_id only if the user is a student 
	validates_presence_of :enrollment_id, :if => :is_student?
	validates_presence_of :school_id, :unless => :is_guardian?
	
	validates_format_of :email, 
						:with => EMAIL_REGEX, 
						:on => :create, 
						:message => "must be a valid email address"
					
	
	validates_length_of :email, :within => 6..MAX_EMAIL
	validates_length_of :username, :maximum => MAX_USERNAME
	validates_length_of :first_name, :maximum => MAX_FIRST_NAME
	validates_length_of :last_name, :maximum => MAX_LAST_NAME
	
	validates_uniqueness_of :email, :case_sensitive => false
	validates_uniqueness_of :enrollment_id, :if => :is_student?
	
	validates_confirmation_of :password,
							  if: lambda { |m| m.password.present? }
	
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
			
	private
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end
		
		def is_student?
			:type == 3
		end
		
		def is_guardian?
			:type == 4
		end

end
