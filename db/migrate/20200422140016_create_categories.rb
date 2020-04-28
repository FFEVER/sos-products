class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_th
      t.references :parent, null: true

    end
  end
end
