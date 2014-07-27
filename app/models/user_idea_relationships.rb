class UserIdeaRelationships < ActiveRecord::Base

	belongs_to :idea, :class_name => "Idea", :foreign_key => "idea_id"
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
	validates_presence_of :idea_id, :user_id
	
	validates_uniqueness_of :idea_id, :scope => [:user_id]
	
end
