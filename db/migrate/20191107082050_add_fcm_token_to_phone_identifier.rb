class AddFcmTokenToPhoneIdentifier < ActiveRecord::Migration[5.2]
  def change
    add_column :phone_identifiers, :fcm_token, :string
  end
end
