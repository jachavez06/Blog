class AddImpressionsCountToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :impressions_count, :int, default: 0
  end
end
