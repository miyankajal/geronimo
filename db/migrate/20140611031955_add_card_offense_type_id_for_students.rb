class AddCardOffenseTypeIdForStudents < ActiveRecord::Migration
   def change
    add_column :student_points, :card_offense_id, :int, :default => 1
  end
end
