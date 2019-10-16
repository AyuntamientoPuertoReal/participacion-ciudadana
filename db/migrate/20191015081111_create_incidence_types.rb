class CreateIncidenceTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :incidence_types do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
