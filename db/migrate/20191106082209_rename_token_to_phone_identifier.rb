class RenameTokenToPhoneIdentifier < ActiveRecord::Migration[5.2]
  def change
    rename_table :tokens, :phone_identifiers
  end
end
