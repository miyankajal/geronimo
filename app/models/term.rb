class Term < ActiveRecord::Base
	belongs_to :school
	validates_presence_of :school_id
end