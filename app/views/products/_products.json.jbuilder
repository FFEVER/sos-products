json.array! products do |product|
  json.partial! "products/product", product: product
end
