class Api::V1::Users::ProductsController < ApplicationController
  before_action :find_product, only: %i[show update destroy checkout]

  def index
    @products = Product.where(user_id: params[:user_id])
  end

  def create
    @product = Product.new(product_params.merge(user_id: params[:user_id]))
    if @product.save
      render status: :created
    else
      render json: {error: @product.errors.full_messages}, status: :bad_request
    end
  end

  def update
    if @product.update(product_params)
      render json: {message: 'Product successfully updated.'}, status: :ok
    else
      render json: {error: @product.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    if @product.destroy
      render json: {message: 'Product successfully deleted.'}, status: :ok
    else
      render json: {error: 'Unable to delete product.'}, status: :bad_request
    end

  end

  def checkout
    if @product.checkout
      render json: {message: 'Successfully checked out'}, status: :ok
    else
      render json: {error: 'Unable to checkout.'}, status: :bad_request
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :long_desc, :price, :stock, :sold_quantity, :category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
