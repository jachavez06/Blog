class AddStateToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :state, :integer, default: 0
    remove_column :articles, :published, :boolean
  end
end
