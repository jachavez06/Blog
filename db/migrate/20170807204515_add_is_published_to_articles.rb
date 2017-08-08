# Add published field  to articles.
class AddIsPublishedToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :published, :boolean, default: false
  end
end
