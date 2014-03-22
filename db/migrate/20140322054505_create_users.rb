class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :remember_token
      t.integer :type
      t.integer :enrollment_id
      t.integer :class_id

      t.timestamps
    end
	
	add_index :users, :email
	add_index :users, [:first_name, :last_name]
  end
  
  
  def self.down
	drop_table :users
  end
  
end
