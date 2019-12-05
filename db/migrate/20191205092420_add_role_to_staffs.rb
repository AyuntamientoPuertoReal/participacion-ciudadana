class AddRoleToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_reference :staffs, :role, foreign_key: true
  end
end
