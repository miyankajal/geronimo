class CreateAddSchoolIdToAllColumns < ActiveRecord::Migration
  def change
	add_column :users, :school_id, :int
	add_column :terms, :school_id, :int
	add_column :points, :school_id, :int
	add_column :class_sections, :school_id, :int
	add_column :alert_settings, :school_id, :int
  end
end
