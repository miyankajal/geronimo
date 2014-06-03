class School < ActiveRecord::Base
	has_many :users
	has_many :terms
	has_many :points
	has_many :class_sections
	has_one :alert_settings
end
