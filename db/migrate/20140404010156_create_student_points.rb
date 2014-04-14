class CreateStudentPoints < ActiveRecord::Migration
  def self.up
    create_table :student_points do |t|
      t.integer :user_id
      t.integer :point_id
	  t.integer :assigned_points
	  t.boolean :is_credit

      t.timestamps
    end
  end
  
  def self.down 
	drop_table :student_points
  end
end
