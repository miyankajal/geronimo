class Idea < ActiveRecord::Base
	has_many :tag_comment_ideas
	has_many :tags, :through => :tag_comment_ideas
	
	has_many :comments
	
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
	belongs_to :moderator_user, :class_name => "User", :foreign_key => "moderator_id"
	belongs_to :posting_portal	
	has_many :user_idea_relationships
	belongs_to :ideas, :class_name => "Idea", :foreign_key => "class_id"
	
	validates_presence_of :idea, :portal_id, :user_id
    self.per_page = 10
end
