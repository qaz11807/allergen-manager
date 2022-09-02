# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens/:id/medicines#index', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'REMOVE_MEDICINES_FROM_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '將抗過敏藥取消關聯到過敏原'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Allergens']

    @medicines = create_list(:medicine, 10, user: @user)
    @allergen = create(:allergen, medicines: @medicines, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = "/api/v1/allergens/#{@allergen.id}/medicines"
  end

  describe 'Add all medicines to the allergen' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取消關聯'

      params = {
        medicine_ids: @medicines.pluck(:id)
      }

      delete(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @allergen.reload
      expect(@allergen.medicines.count).to eq(0)
    end
  end
end
