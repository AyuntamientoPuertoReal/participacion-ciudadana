class DropOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :pu_ws
    drop_table :web_sections
  end
end
