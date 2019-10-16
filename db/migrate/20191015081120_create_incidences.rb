class CreateIncidences < ActiveRecord::Migration[5.2]
  def change
    create_table :incidences do |t|
      t.text :description, null: false
      t.string :image_url
      t.references :token, null: false, foreign_key: true
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.references :incidence_type, null: true, foreign_key: true

      t.timestamps
    end
  end
end
