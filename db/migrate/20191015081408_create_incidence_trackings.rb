class CreateIncidenceTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :incidence_trackings do |t|
      t.references :incidence, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: true
      t.string :processing_units, null: false
      t.integer :status, null: false
      t.integer :previous_status, null: false
      t.string :message, null: true
      t.timestamp :date, null: false

      t.timestamps
    end
  end
end
