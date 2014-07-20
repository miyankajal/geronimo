class StudentPoint < ActiveRecord::Base
	belongs_to :user
	belongs_to :point
	
	validates_presence_of :user_id, :point_id, :assigned_points, :card_offense_id

end