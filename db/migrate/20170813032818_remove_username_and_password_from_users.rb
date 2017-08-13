class RemoveUsernameAndPasswordFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :username, :string
    remove_column :users, :admin, :boolean
    remove_column :users, :password_digest, :string
  end
end
