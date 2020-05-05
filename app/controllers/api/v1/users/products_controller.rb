class Api::V1::Users::ProductsController < ApplicationController
  before_action :authorize_admin, if: :require_authorization?
  before_action :verify_user, only: %i[create destroy], if: :require_authorization?
  before_action :find_product, only: %i[show update destroy]

  def index
    @products_of_user = Product.where(user_id: params[:user_id])
    @products = @products_of_user.page(params[:page])
    @total_pages = @products.total_pages
    @current_page = @products.current_page
    @total_products = @products_of_user.count
    @limit_per_page = @products.limit_value
  end

  def create
    @product = Product.new(product_params.merge(user_id: params[:user_id]))
    if @product.save
      render status: :created
    else
      render json: {errors: @product.errors.full_messages}, status: :bad_request
    end
  end

  def update
    if @product.update(product_params)
      render status: :ok
    else
      render json: {errors: @product.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    if @product.destroy
      render json: {message: 'Product successfully deleted.'}, status: :ok
    else
      render json: {errors: 'Unable to delete product.'}, status: :bad_request
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :long_desc, :price, :stock, :sold_quantity, :category_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id], user_id: params[:user_id])
    render json: {errors: 'Not Found'}, status: :not_found if @product.nil?
  end

  def verify_user
    render json: {errors: 'No Permission'}, status: :forbidden if params[:user_id] != @jwt_decoded[:user_id].to_s
  end

end
