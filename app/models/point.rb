class Point < ActiveRecord::Base

	validates_presence_of :description, :value, :school_id
	
	validates_length_of :description, :maximum => 1024
	
	has_many :student_points, dependent: :destroy
	has_many :users, through: :student_points 
	belongs_to :school
end
