class AlertSetting < ActiveRecord::Base
	has_one :school
	validates_presence_of :school_id
end
