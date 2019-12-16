class RemoveDateFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :incidence_trackings, :date, :timestamp
    remove_column :news, :date_of_creation, :timestamp
    remove_column :news, :date_of_last_edit, :timestamp
  end
end
