class CreateUserPointsRelationship < ActiveRecord::Migration
  def self.up
    create_table :user_points_relationships do |t|
      t.integer :user_id
      t.string :points_id
      t.integer :point
      t.boolean :is_credit
	  
	  t.timestamps
    end
  end
  
  def self.down 
	drop_table :user_points_relationships
  end
end
