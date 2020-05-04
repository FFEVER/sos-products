json.products do
  json.partial! 'products/products', products: @products
end
json.current_page @current_page
json.total_pages @total_pages
json.total_products @total_products
json.limit_per_page @limit_per_page
