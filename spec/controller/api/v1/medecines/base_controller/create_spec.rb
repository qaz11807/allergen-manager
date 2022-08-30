# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines#create', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'CREATE_MEDICINE'
    example.metadata[:rpdoc_action_name] = '新增抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Medicines']

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      name: 'anti allergery',
      expired_at: Time.now + 3.day
    }
    @path = '/api/v1/medicines'
  end

  describe 'Create medicine' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功新增資料'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end
  end
end
