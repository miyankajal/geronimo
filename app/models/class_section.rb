class ClassSection < ActiveRecord::Base

	validates_presence_of :description, :value
	
	validates_length_of :description, :maximum => 1024
	
	has_many :teacher_class_relationships, dependent: :destroy
	has_many :users, through: :teacher_class_relationships 
end
