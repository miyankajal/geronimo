class Idea < ActiveRecord::Base
	has_many :tag_comment_ideas
	has_many :tags, :through => :tag_comment_ideas
	
	has_many :comments
	
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
	belongs_to :moderator_user, :class_name => "User", :foreign_key => "moderator_id"
	belongs_to :posting_portal	
	
	validates_presence_of :idea, :moderator_id, :portal_id, :user_id
end
