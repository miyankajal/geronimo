class AddUserTokenToUser < ActiveRecord::Migration
  def change
      add_column :users, :new_user_token, :string
  end
end
