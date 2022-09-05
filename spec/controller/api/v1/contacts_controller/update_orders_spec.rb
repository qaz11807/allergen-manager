# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts#update_order', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_CONTAT_ORDER'
    example.metadata[:rpdoc_action_name] = '更新聯絡人排序'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Contacts']

    @contacts = create_list(:contact, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = '/api/v1/contacts/orders'
  end

  describe 'Update contact' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功更新資料'

      params = {
        contact_ids: @contacts.pluck(:id).sample(10)
      }

      put(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      @user.reload
      expect(@user.contacts.by_order.pluck(:id)).to match_array(params[:contact_ids])
    end
  end
end
