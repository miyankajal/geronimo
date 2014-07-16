class Tag < ActiveRecord::Base
	has_many :tag_comment_ideas
	has_many :comments, :through => :tag_comment_ideas
	has_many :ideas, :through => :tag_comment_ideas
	belongs_to :school
	validates_presence_of :school_id
end
