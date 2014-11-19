class AddKeyToPoints < ActiveRecord::Migration
  def change
      add_column :points, :key, :int
  end
end
