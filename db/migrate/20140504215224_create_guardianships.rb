class CreateGuardianships < ActiveRecord::Migration
  def self.up
    create_table :guardianships do |t|
      t.integer :user_id
      t.integer :guardian_id

      t.timestamps
    end
  end
  
  def self.down
    drop_table :guardianships
  end
end
