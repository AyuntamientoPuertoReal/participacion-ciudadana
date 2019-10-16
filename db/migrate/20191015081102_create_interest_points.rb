class CreateInterestPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :interest_points do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :image_url, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false

      t.timestamps
    end
  end
end
