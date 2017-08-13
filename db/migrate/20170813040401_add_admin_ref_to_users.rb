class AddAdminRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :users, :admin, foreign_key: true
  end
end
