class Comment < ActiveRecord::Base
	has_many :tag_comment_ideas
	has_many :tags, :through => :tag_comment_ideas
	
	belongs_to :idea
	
	belongs_to :user
	
end
