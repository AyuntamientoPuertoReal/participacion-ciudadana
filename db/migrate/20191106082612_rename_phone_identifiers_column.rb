class RenamePhoneIdentifiersColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :phone_identifiers, :token, :phone_identifier
    rename_column :incidences, :token_id, :phone_identifier_id
  end
end
