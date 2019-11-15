class ChangesToNews < ActiveRecord::Migration[5.2]
  def change
    remove_column :news, :staff_processing_units, :string
    remove_column :news, :type_of_action, :integer
    remove_column :news, :is_active, :boolean
    remove_column :news, :base_instance_id, :integer
    remove_column :news, :previous_instance_id, :integer
    remove_column :news, :web_section_id, :integer
    rename_column :news, :date, :date_of_creation
    rename_column :news, :staff_id, :author_id
    add_column :news, :date_of_last_edit, :datetime
    add_reference :news, :last_editor, foreign_key: { to_table: 'staffs' }
  end
end
