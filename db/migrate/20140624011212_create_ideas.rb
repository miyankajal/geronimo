class CreateIdeas < ActiveRecord::Migration
  def self.up
  
      create_table :ideas do |t|
      t.text :idea
      t.integer :user_id
      t.integer :moderator_id
      t.integer :likes_count, default: 0
      t.integer :tag_id
      t.integer :portal_id, default: 1
	  t.integer :class_id
      t.boolean :accepted, default: false
	  
	  t.timestamps
    end
	
	add_index :ideas, [:user_id, :portal_id, :accepted], name: 'IX_Ideas'
	add_index :ideas, [:tag_id], name: 'IX_Ideas_Tags'
	add_index :ideas, [:portal_id], name: 'IX_Ideas_Portals'
	add_index :ideas, [:moderator_id, :accepted], name: 'IX_Ideas_Moderator'
	add_index :ideas, [:class_id], name: 'IX_Ideas_Classes'
  end
  
  def self.down
	drop_table :ideas
	
	remove_index(:ideas, :name => 'IX_Ideas')
	remove_index(:ideas, :name => 'IX_Ideas_Tags')
	remove_index(:ideas, :name => 'IX_Ideas_Portals')
	remove_index(:ideas, :name => 'IX_Ideas_Moderator')
	remove_index(:ideas, :name => 'IX_Ideas_Classes')

  end
end
