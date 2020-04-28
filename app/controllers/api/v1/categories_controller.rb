class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.all_parents
  end

  def show
    @category = Category.find(params[:id])
  end

  def products
    @category = Category.find(params[:id])
    @products = @category.all_products
  end

end
