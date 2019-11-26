class RemovePasswordAndModifyCanPublishFromStaffs < ActiveRecord::Migration[5.2]
  def change
    remove_column :staffs, :password, :string
    change_column :staffs, :can_publish, :boolean, :default => false
  end
end
