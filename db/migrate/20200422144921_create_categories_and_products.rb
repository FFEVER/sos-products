class CreateCategoriesAndProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_products, id: false do |t|
      t.belongs_to :category
      t.belongs_to :product
    end
  end
end
