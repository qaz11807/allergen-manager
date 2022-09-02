# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts#bulk_destroy', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'DELETE_CONTACTS'
    example.metadata[:rpdoc_action_name] = '刪除多個聯絡人'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Contacts']

    @contacts = create_list(:contact, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = '/api/v1/contacts'
  end

  describe 'Delete contacts' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功刪除資料'

      params = {
        contact_ids: @contacts.pluck(:id).sample(5)
      }

      delete(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      expect(Contact.find_by(id: params[:contact_ids])).to eq(nil)
    end
  end
end
