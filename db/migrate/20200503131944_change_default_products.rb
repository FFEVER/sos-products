class ChangeDefaultProducts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :products, :sold_quantity, 0
  end
end
