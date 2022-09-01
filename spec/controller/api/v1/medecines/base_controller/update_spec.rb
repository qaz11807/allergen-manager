# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#update', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_MEDICINE'
    example.metadata[:rpdoc_action_name] = '更新抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @medicine = create(:medicine, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      name: 'new name'
    }
    @path = '/api/v1/medicines'
  end

  describe 'Update medicine' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功更新資料'

      put("#{@path}/#{@medicine.id}", headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 404' do |example|
      example.metadata[:rpdoc_example_key] = '404'
      example.metadata[:rpdoc_example_name] = '更新資料失敗(找不到抗過敏藥)'

      put("#{@path}/123456", headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_0003)
    end
  end
end
