class AddIndexToUserRememberToken < ActiveRecord::Migration
  def self.up
	add_index :users, :remember_token, {name: 'index_users_remember_token', unique: true}
  end
  
  def self.down
	remove_index :users, :remember_token => 'index_users_remember_token'
  end
end
