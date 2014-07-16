class TagCommentIdea < ActiveRecord::Base
	belongs_to :comment
	belongs_to :idea
	belongs_to :tag
  
	validates_presence_of :idea_id, :tag_id
	
	validates_uniqueness_of :idea_id, :scope => [:tag_id]
end
