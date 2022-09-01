# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/oauth/token', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'OAUTH_TOKEN'
    example.metadata[:rpdoc_action_name] = '登入'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'User']

    @headers = {
      'Content-Type': 'application/json'
    }
    @params = {
      username: @user.email,
      password: @user.password,
      grant_type: 'password',
      client_id: @app.uid,
      client_secret: @app.secret
    }
    @path = '/oauth/token'
  end

  describe 'Oauth get access_token' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '登入成功'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end
  end
end
