# Need to redo ckeditor intgration.
class DeleteCkeditorAssets < ActiveRecord::Migration[5.1]
  def change
    drop_table :ckeditor_assets
  end
end
