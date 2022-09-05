# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens/:id/medicines#index', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'ADD_MEDICINES_TO_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '將抗過敏藥關聯到過敏原'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Allergens']

    @allergen = create(:allergen, user: @user)
    @medicines = create_list(:medicine, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = "/api/v1/allergens/#{@allergen.id}/medicines"
  end

  describe 'Add all medicines to the allergen' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功新增關聯'

      params = {
        medicine_ids: @medicines.pluck(:id)
      }

      post(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @allergen.reload
      expect(@allergen.medicines.count).to eq(@medicines.length)
    end
  end
end
