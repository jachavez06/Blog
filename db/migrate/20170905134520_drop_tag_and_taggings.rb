class DropTagAndTaggings < ActiveRecord::Migration[5.1]
  def change
    drop_table :tags, force: :cascade
    drop_table :taggings, force: :cascade
  end
end
