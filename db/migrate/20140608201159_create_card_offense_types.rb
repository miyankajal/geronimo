class CreateCardOffenseTypes < ActiveRecord::Migration
  def self.up
    create_table :card_offense_types do |t|
      t.string :description
    end
  end
  
  def self.down
	drop_table :card_offense_types
  end
end
