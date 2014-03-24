class CreateTeacherRoles < ActiveRecord::Migration
  def change
    create_table :teacher_roles do |t|
      t.string :description

      t.timestamps
    end
  end
end
