class CreateStudentPoints < ActiveRecord::Migration
  def change
    create_table :student_points do |t|
      t.integer :user_id
      t.integer :point_id
      t.integer :point
      t.boolean :is_credit

      t.timestamps
    end
  end
end
