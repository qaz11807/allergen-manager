# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines/:id/allergens#index', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'GET_MEDICINES_RELATED_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '取得該抗過敏藥相關的所有過敏原'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @allergens = create_list(:allergen, 10, user: @user)
    @allergens_unlinked = create_list(:allergen, 3, user: @user)
    @medicine = create(:medicine, allergens: @allergens, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = "/api/v1/medicines/#{@medicine.id}/allergens"
  end

  describe 'Get all allergens belongs to the medicine' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取得資料'

      get(@path, headers: @headers)
      expect(response).to have_http_status(:ok)
      expect(json['data']['total_count']).to eq(@allergens.length)
    end

    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200_unlinked'
      example.metadata[:rpdoc_example_name] = '成功取得資料(還未連結的過敏原)'

      params = {
        linked: false
      }
      get(@path, headers: @headers, params: params)
      expect(response).to have_http_status(:ok)
      expect(json['data']['total_count']).to eq(@allergens_unlinked.length)
    end
  end
end
