# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#update', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '更新過敏原'
    example.metadata[:rpdoc_example_folders] = ['Allergens']

    @allergen = create(:allergen, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      name: 'new name'
    }
    @path = "/api/v1/allergens"
  end

  describe 'Update allergen' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功更新資料'

      put("#{@path}/#{@allergen.id}", headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 404' do |example|
      example.metadata[:rpdoc_example_key] = '404'
      example.metadata[:rpdoc_example_name] = '更新資料失敗(找不到過敏原)'

      put("#{@path}/123456", headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_0002)
    end
  end
end
