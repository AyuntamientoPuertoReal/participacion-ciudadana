class CreatePuIts < ActiveRecord::Migration[5.2]
  def change
    create_table :pu_its do |t|
      t.references :processing_unit, null: false, foreign_key: true
      t.references :incidence_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
