class CreateUserIdeaRelationships < ActiveRecord::Migration
  def self.up
    create_table :user_idea_relationships do |t|
	 
	  t.integer :idea_id
      t.integer :user_id
      t.boolean :like, default: false
	  t.boolean :report, default: false
	  
      t.timestamps
    end
	
	add_index :user_idea_relationships, [:idea_id, :user_id], name: 'IX_User_Idea'
  end
  
  def self.down
	remove_index(:user_idea_relationships, :name => 'IX_User_Idea')
	
	drop_table :user_idea_relationships
  end
end
