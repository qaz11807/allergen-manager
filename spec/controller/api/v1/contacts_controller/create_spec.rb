# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts#create', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'CREATE_CONTACT'
    example.metadata[:rpdoc_action_name] = '新增聯絡人'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Contacts']

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = '/api/v1/contacts'
  end

  describe 'Create contact' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功新增資料'

      params = {
        name: 'cc',
        phone: '+886-970-935-955',
        description: 'test 1',
      }

      post(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      expect(Contact.find_by(id: json['data']['id'])).to be_present
    end
  end
end
