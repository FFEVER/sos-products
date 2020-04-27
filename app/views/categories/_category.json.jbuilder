json.(category, :id, :name_en, :name_th, :parent_id)
json.subcategories do
  json.array! category.subcategories do |subcategory|
    json.(subcategory, :id, :name_en, :name_th, :parent_id)
  end
end
