class CreatePuWs < ActiveRecord::Migration[5.2]
  def change
    create_table :pu_ws do |t|
      t.references :processing_unit, null: false, foreign_key: true
      t.references :web_section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
