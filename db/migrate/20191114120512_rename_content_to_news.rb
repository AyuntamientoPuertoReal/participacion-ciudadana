class RenameContentToNews < ActiveRecord::Migration[5.2]
  def change
    rename_table :contents, :news
  end
end
