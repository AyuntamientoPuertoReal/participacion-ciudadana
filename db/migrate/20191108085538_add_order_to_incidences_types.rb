class AddOrderToIncidencesTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :incidence_types, :order, :integer
  end
end
