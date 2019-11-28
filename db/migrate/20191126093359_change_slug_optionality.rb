class ChangeSlugOptionality < ActiveRecord::Migration[5.2]
  def change
    change_column :news, :slug, :string, null: true
  end
end
