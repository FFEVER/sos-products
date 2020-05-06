require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  let!(:categories) {FactoryBot.create_list(:category, 20)}

  describe "GET #index" do
    before do
      headers = {'ACCEPT': 'application/json'}
      get api_v1_categories_path, headers: headers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected category attributes" do
      category_list = JSON.parse(response.body)
      expect(category_list.count).to match(categories.count)
      expect(category_list[0].keys).to match_array(%w[id name_en name_th parent_id subcategories])
    end
  end
end
