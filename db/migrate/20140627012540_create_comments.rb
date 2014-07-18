class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :idea_id
      t.text :comment
      t.integer :user_id
      t.boolean :accepted
	  t.integer :likes_count
	  
	  t.timestamps
    end
	
	add_index :comments, [:user_id, :idea_id, :accepted], name: 'IX_Comments'
  end
  
  def self.down
	drop_table :comments
	
	remove_index(:comments, :name => 'IX_Comments')
  end
end
