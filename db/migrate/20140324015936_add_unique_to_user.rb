class AddUniqueToUser < ActiveRecord::Migration
  def self.up
	remove_index :users, :email
	remove_index :users, [:first_name, :last_name]
	
	add_index :users, :email, {name: 'index_users_email', unique: true}
	add_index :users, [:first_name, :last_name], {name: 'index_users_names'}
  end
  
  def self.down
	remove_index :users, :name => 'index_users_email'
	remove_index :users, :name => 'index_users_names'
  end
end
