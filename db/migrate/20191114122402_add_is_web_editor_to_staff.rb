class AddIsWebEditorToStaff < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :is_web_editor, :boolean, :default => 'false'
  end
end
