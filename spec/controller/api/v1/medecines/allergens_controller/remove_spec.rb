# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines/:id/allergens#remove', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'REMOVE_ALLERGENS_FROM_MEDICINE'
    example.metadata[:rpdoc_action_name] = '將過敏原取消關聯到該抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @allergens = create_list(:allergen, 10, user: @user)
    @medicine = create(:medicine, allergens: @allergens, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = "/api/v1/medicines/#{@medicine.id}/allergens"
  end

  describe 'Remove allergens to the medicine' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取消關聯'

      params = {
        allergen_ids: @allergens.pluck(:id)
      }

      delete(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @medicine.reload
      expect(@medicine.allergens.count).to eq(0)
    end
  end
end
