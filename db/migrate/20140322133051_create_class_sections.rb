class CreateClassSections < ActiveRecord::Migration
  def self.up
    create_table :class_sections do |t|
      t.string :description

      t.timestamps
    end
  end
  
  def self.down
	drop_table :class_sections
  end
end
