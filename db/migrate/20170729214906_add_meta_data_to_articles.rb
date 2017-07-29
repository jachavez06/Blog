class AddMetaDataToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :meta_data_title, :string
    add_column :articles, :meta_data_description, :string
    add_column :articles, :meta_data_keywords, :string
  end
end
