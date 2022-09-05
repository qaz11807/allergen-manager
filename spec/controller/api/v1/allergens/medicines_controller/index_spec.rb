# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens/:id/medicines#index', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'GET_ALLERGEN_RELATED_MEDICINES'
    example.metadata[:rpdoc_action_name] = '取得該過敏原相關的所有過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Allergens']

    @medicines = create_list(:medicine, 10, user: @user)
    @medicines_unlinked = create_list(:medicine, 10, user: @user)
    @allergen = create(:allergen, medicines: @medicines, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = "/api/v1/allergens/#{@allergen.id}/medicines"
  end

  describe 'Get all medicines belongs to the allergen' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取得資料'

      get(@path, headers: @headers)
      expect(response).to have_http_status(:ok)
      expect(json['data']['total_count']).to eq(@medicines.length)
    end

    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200_unlinked'
      example.metadata[:rpdoc_example_name] = '成功取得資料(還未連結的抗過敏藥)'

      params = {
        linked: false
      }
      get(@path, headers: @headers, params: params)
      expect(response).to have_http_status(:ok)
      expect(json['data']['total_count']).to eq(@medicines_unlinked.length)
    end
  end
end
