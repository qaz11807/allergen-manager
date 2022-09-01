# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/profile#update', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_PROFILE'
    example.metadata[:rpdoc_action_name] = '更新個人資料'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Profile']

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      birthday: '2021/03/25',
      name: 'chang',
      lang: 'zh-TW'
    }
    @path = '/api/v1/profile'
  end

  describe 'PUT profile' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '更新成功'

      put(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 400' do |example|
      example.metadata[:rpdoc_example_key] = '400'
      example.metadata[:rpdoc_example_name] = '更新失敗(參數不合法)'

      @params[:birthday] = '2035/01/01'

      put(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
    end
  end
end
