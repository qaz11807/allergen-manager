# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/user#register', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'REGISTER_USER'
    example.metadata[:rpdoc_action_name] = '註冊'
    example.metadata[:rpdoc_example_folders] = ['User']

    @headers = {
      'Content-Type': 'application/json'
    }
    @params = {
      email: 'new_email@gmail.com',
      password: 'rootroot',
      profile: {
        birthday: '2021/03/25',
        name: 'chang',
        lang: 'zh-TW'
      },
      client_id: @app.uid,
      client_secret: @app.secret
    }
    @path = '/api/v1/user/register'
  end

  describe 'Popst users/register' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '註冊成功'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 400 if missing required params' do |example|
      example.metadata[:rpdoc_example_key] = '400_000'
      example.metadata[:rpdoc_example_name] = '註冊失敗(缺少必要參數)'

      @params.delete(:password)

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_000)
    end

    it 'should return code 400' do |example|
      example.metadata[:rpdoc_example_key] = '400_002'
      example.metadata[:rpdoc_example_name] = '註冊失敗(信箱不合法)'

      @params[:email] = 'test.acc'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_002)
    end

    it 'should return code 400 if email already used' do |example|
      example.metadata[:rpdoc_example_key] = '400_005'
      example.metadata[:rpdoc_example_name] = '註冊失敗(信箱已被使用)'

      @params[:email] = @user.email

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_005)
    end
  end
end
