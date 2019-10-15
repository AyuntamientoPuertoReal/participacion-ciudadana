class CreateProcessingUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :processing_units do |t|
      t.string :code, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
