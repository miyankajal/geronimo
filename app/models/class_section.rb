class ClassSection < ActiveRecord::Base

	validates_presence_of :description, :school_id
	
	validates_length_of :description, :maximum => 1024
	
	has_many :teacher_class_relationships, dependent: :destroy
	has_many :users, through: :teacher_class_relationships 
	has_many :ideas, dependent: :destroy
	belongs_to :school
end
