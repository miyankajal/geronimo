class CreatePostingPortals < ActiveRecord::Migration
  def self.up
    create_table :posting_portals do |t|
      t.string :description, :limit => 64
	  
	  t.timestamps
    end
  end
  
  def self.down
	drop_table :posting_portals
  end
end
