class ChangeInterestPointImageOptionality < ActiveRecord::Migration[5.2]
  def change
    change_column :interest_points, :image_url, :string, null: true
  end
end
