# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines/:id/allergens#add', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'ADD_ALLERGENS_TO_MEDICINE'
    example.metadata[:rpdoc_action_name] = '將過敏原關聯到該抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @allergens = create_list(:allergen, 10, user: @user)
    @medicine = create(:medicine, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = "/api/v1/medicines/#{@medicine.id}/allergens"
  end

  describe 'Add all allergens to the medicine' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功新增關聯'

      params = {
        allergen_ids: @allergens.pluck(:id)
      }

      post(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @medicine.reload
      expect(@medicine.allergens.count).to eq(@allergens.length)
    end
  end
end
