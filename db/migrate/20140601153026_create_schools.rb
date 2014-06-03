class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :phone_no

      t.timestamps
    end
  end
  
  def self.down
    drop_table :schools
  end
end
