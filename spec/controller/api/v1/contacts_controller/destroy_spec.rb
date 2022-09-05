# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts#destroy', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'DELETE_CONTACT'
    example.metadata[:rpdoc_action_name] = '刪除聯絡人'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Contacts']

    @contact = create(:contact, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = '/api/v1/contacts'
  end

  describe 'Destroy contact' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功刪除資料'

      delete("#{@path}/#{@contact.id}", headers: @headers)
      expect(response).to have_http_status(:ok)

      expect(Contact.find_by(id: @contact.id)).to eq(nil)
    end

    it 'should return code 404' do |example|
      example.metadata[:rpdoc_example_key] = '404'
      example.metadata[:rpdoc_example_name] = '更新資料失敗(找不到聯絡人)'

      delete("#{@path}/123456", headers: @headers)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_0004)
    end
  end
end
