require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let!(:categories) { FactoryBot.create_list(:category, 20) }
  let!(:products) { FactoryBot.create_list(:product, 20) }

  def default_headers
    token = JsonWebToken.encode({user_id: 1, role: 'admin'})
    {'ACCEPT': 'application/json', 'Authorization': "Bearer #{token}"}
  end


  describe "GET #index" do
    before do
      get api_v1_products_path, headers: default_headers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected product attributes" do
      hash_body = JSON.parse(response.body)
      expect(hash_body.keys).to match_array(%w[products current_page total_pages total_products limit_per_page])
      expect(hash_body['products'][0].keys).to match_array(%w[id title user_id long_desc price stock sold_quantity created_at updated_at categories])
    end
  end

  describe "GET #show" do
    before do
      headers = {'ACCEPT': 'application/json'}
      get api_v1_product_path(products.first), headers: default_headers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected product attributes" do
      hash_body = JSON.parse(response.body)
      expect(hash_body.keys).to match_array(%w[id title user_id long_desc price stock sold_quantity created_at updated_at categories])
    end
  end

  describe "POST #create" do
    before do
      post '/api/v1/users/1/products', headers: default_headers, params: {
          product: {
              title: 'title',
              long_desc: 'long_desc',
              user_id: 1,
              price: 35.5,
              stock: 50,
              category_id: categories.first.id
          }
      }
    end
    it 'returns the title' do
      expect(JSON.parse(response.body)['title']).to eq('title')
    end
    it 'returns the long descriptions' do
      expect(JSON.parse(response.body)['long_desc']).to eq('long_desc')
    end
    it 'returns the user_id' do
      expect(JSON.parse(response.body)['user_id']).to eq(1)
    end
    it 'returns the price' do
      expect(JSON.parse(response.body)['price']).to eq(35.5)
    end
    it 'returns the stock' do
      expect(JSON.parse(response.body)['stock']).to eq(50)
    end
    it 'returns the sold quantity' do
      expect(JSON.parse(response.body)['sold_quantity']).to eq(0)
    end
    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT #update" do
    before(:each) do
      @product = FactoryBot.create(:product)
    end

    it 'updates a product' do
      @new_title = Faker::Lorem.question
      @new_long_desc = Faker::Lorem.sentence
      @new_stock = Faker::Number.between(from: 50, to: 50000)
      @new_price = Faker::Number.between(from: 50, to: 50000)
      @new_category_id = categories.second.id
      put "/api/v1/users/1/products/#{@product.id}", headers: default_headers, params: {
          product: {
              title: @new_title,
              long_desc: @new_long_desc,
              user_id: 1,
              price: @new_price,
              stock: @new_stock,
              category_id: @new_category_id
          }
      }

      expect(response).to have_http_status(:success)
      expect(Product.find(@product.id).title).to eq(@new_title)
      expect(Product.find(@product.id).long_desc).to eq(@new_long_desc)
      expect(Product.find(@product.id).stock).to eq(@new_stock)
      expect(Product.find(@product.id).price).to eq(@new_price)
      expect(Product.find(@product.id).categories.first.id).to eq(@new_category_id)
    end
  end

end
