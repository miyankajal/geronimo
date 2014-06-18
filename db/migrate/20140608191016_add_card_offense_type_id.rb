class AddCardOffenseTypeId < ActiveRecord::Migration
  def change
    add_column :points, :card_offense_id, :int, :default => 1
  end
end
