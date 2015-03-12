class AddClassToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :class_id, :int
  end
end
