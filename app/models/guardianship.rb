class Guardianship < ActiveRecord::Base
	belongs_to :user
	belongs_to :guardian, :class_name => "User"
end
