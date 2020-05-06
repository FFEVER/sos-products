json.(product, :id, :title, :user_id, :long_desc, :price, :stock, :sold_quantity, :created_at, :updated_at)
json.categories product.category_tree
