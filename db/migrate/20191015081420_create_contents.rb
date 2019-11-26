class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.timestamp :date, null: false
      t.references :staff, null: false, foreign_key: true
      t.string :staff_processing_units, null: false
      t.string :type_of_action, null: false
      t.boolean :is_active, null: false
      t.references :base_instance, null: true
      t.references :previous_instance, null: true
      t.string :title, null: true
      t.string :description, null: true
      t.text :body, null: true
      t.string :image_url, null: true
      t.references :web_section, null: true, foreign_key: true
      t.boolean :published, null: true

      t.timestamps
    end
  end
end
