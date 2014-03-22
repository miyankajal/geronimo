class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.string :description
      t.integer :value
      t.boolean :credit

      t.timestamps
    end
  end
  
  def self.down 
	drop_table :points
  end
end
