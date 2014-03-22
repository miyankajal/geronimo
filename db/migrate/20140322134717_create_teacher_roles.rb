class CreateTeacherRoles < ActiveRecord::Migration
  def self.up
    create_table :teacher_roles do |t|
      t.string :description

      t.timestamps
    end
  end
  
  def self.down
	drop_table :teacher_roles
  end

end
