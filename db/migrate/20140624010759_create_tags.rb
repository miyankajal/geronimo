class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :description, :limit => 64
	  t.integer :points
	  
	  t.timestamps
    end
  end
  
  def self.down
	drop_table :tags
  end
end
