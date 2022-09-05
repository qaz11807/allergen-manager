# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines#index', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'GET_MEDICINES'
    example.metadata[:rpdoc_action_name] = '取得所抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @medicines = create_list(:medicine, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = '/api/v1/medicines'
  end

  describe 'Get all medicines' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取得資料'

      get(@path, headers: @headers)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 200 with pagination' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取得資料'

      params = {
        page: 1,
        per_page: 5
      }

      get(@path, headers: @headers, params: params)
      expect(response).to have_http_status(:ok)
      expect(json['data']['medicines'].length).to eq(params[:per_page])
    end
  end
end
