class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.boolean :can_publish, null: false
      t.string :full_name, null: false

      t.timestamps
    end
  end
end
