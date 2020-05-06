class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.all_parents
  end

  def show
    @category = Category.find(params[:id])
  end

  def products
    @category = Category.find(params[:id])
    @products_in_cat = @category.all_products
    limit_per_page = Product.page(0).limit_value

    @products = Kaminari.paginate_array(@products_in_cat).page(params[:page]).per(limit_per_page)
    @total_pages = @products.total_pages
    @current_page = @products.current_page
    @total_products = @products_in_cat.count
    @limit_per_page = @products.limit_value
  end

end
