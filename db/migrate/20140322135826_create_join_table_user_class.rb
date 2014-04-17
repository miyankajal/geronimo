class CreateJoinTableUserClass < ActiveRecord::Migration
  def self.up
	create_table :teacher_class_relationships do |t|
		t.integer :user_id
		t.integer :class_section_id
		t.integer :teacher_role_id

	end
  end
  
  def self.down
	drop_table :teacher_class_relationships
  end
end
