class StudentPoint < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :point_id, :point, :is_credit
	
	default_scope -> {order('created_at DESC')}
end
