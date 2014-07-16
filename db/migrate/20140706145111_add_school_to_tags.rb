class AddSchoolToTags < ActiveRecord::Migration
  def change
	add_column :tags, :school_id, :int
  end
end
