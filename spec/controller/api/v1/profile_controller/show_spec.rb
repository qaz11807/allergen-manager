# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/profile#show', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'GET_PROFILE'
    example.metadata[:rpdoc_action_name] = '取得個人資料'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Profile']

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = '/api/v1/profile'
  end

  describe 'Get profile' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功取得資料'

      get(@path, headers: @headers)
      expect(response).to have_http_status(:ok)
    end
  end
end
