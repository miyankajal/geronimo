class TeacherClassRelationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :class_section
	
    validates_presence_of :user_id, :class_section_id, :teacher_role_id
	
	validates :user_id, :uniqueness => {:scope => [:class_section_id, :teacher_role_id]}
end
