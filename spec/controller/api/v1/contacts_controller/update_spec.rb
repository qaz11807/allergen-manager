# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts#update', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_CONTACT'
    example.metadata[:rpdoc_action_name] = '更新抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Contacts']

    @contact = create(:contact, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = '/api/v1/contacts'
  end

  describe 'Update contact' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功更新資料'

      params = {
        name: 'new name'
      }

      put("#{@path}/#{@contact.id}", headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @contact.reload
      expect(@contact.name).to eq(params[:name])
    end

    it 'should return code 404' do |example|
      example.metadata[:rpdoc_example_key] = '404'
      example.metadata[:rpdoc_example_name] = '更新資料失敗(找不到聯絡人)'

      put("#{@path}/123456", headers: @headers)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_0004)
    end
  end
end
