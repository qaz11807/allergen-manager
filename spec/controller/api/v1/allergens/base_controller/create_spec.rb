# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#create', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'CREATE_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '新增過敏原'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Api', 'V1', 'Allergens']

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      name: 'fruit'
    }
    @path = '/api/v1/allergens'
  end

  describe 'Create allergen' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功新增資料'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end
  end
end
