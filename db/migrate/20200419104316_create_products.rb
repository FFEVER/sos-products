class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :user_id, index: true
      t.text :long_desc
      t.float :price
      t.integer :stock
      t.integer :sold_quantity
      t.timestamps
    end
  end
end
