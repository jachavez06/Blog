class RemoveUserRefFromAdmin < ActiveRecord::Migration[5.1]
  def change
    remove_reference :admins, :user, index: true
  end
end
