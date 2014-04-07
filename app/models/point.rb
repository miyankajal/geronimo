class Point < ActiveRecord::Base

	validates_presence_of :description, :value
	
	validates_length_of :description, :maximum => 1024
end
