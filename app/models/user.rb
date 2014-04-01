class User < ActiveRecord::Base

	#attr_accessor :password, :verify_password, :new_password
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	
	MAX_EMAIL = 64
	MAX_PASSWORD = 64
	MAX_USERNAME = 64
	MAX_FIRST_NAME = MAX_LAST_NAME = 64
	EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
	
	has_one :class_section
	
	#has_one :user_type

	#, :through => :class_sections, :conditions => "type = 3"
	
	has_secure_password
	
	validates_presence_of :username, :email, :password_digest, :first_name, :last_name
	#validates_presence_of :class_id, :if => (:type == 3) #should have a class_id and enrollment_id only if the user is a student 
	
	validates_format_of :email, 
						:with => EMAIL_REGEX, 
						:on => :create, 
						:message => "must be a valid email address"
					
	
	validates_length_of :email, :within => 4..MAX_EMAIL
	#validates_length_of :password, :within => 4..MAX_PASSWORD
	validates_length_of :username, :maximum => MAX_USERNAME
	validates_length_of :first_name, :maximum => MAX_FIRST_NAME
	validates_length_of :last_name, :maximum => MAX_LAST_NAME
	
	validates_uniqueness_of :email, :case_sensitive => false
	#validates_uniqueness_of :enrollment_id 
	
	validates_confirmation_of :password,
							  if: lambda { |m| m.password.present? }
	
	self.inheritance_column = nil
	
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	
	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	private
		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end

end
