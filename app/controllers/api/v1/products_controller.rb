class Api::V1::ProductsController < ApplicationController
  before_action :find_product, except: %i[index]

  def index
    @products = Product.all
  end

  def show
  end

  def checkout
    if @product.checkout(checkout_params)
      render status: :ok
    else
      render json: {error: 'Unable to checkout.'}, status: :bad_request
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def checkout_params
    params.require(:quantity)
  end


end
