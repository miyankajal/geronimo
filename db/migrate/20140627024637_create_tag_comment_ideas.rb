class CreateTagCommentIdeas < ActiveRecord::Migration
  def self.up
    create_table :tag_comment_ideas do |t|
      t.integer :tag_id
      t.integer :comment_id
      t.integer :idea_id

      t.timestamps
    end
	
	add_index :tag_comment_ideas, [:tag_id, :comment_id, :idea_id]
  end
  
  def self.down
	remove_index(:tag_comment_ideas, :name => 'IX_Tag_Comment_Ideas')
	
	drop_table :tag_comment_ideas
	
  end
end
