class TagCommentIdea < ActiveRecord::Base
	belongs_to :comment
	belongs_to :idea
	belongs_to :tag
  
end
