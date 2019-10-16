class CreatePuStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :pu_staffs do |t|
      t.references :staff, null: false, foreign_key: true
      t.references :processing_unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
