# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/medicines#bulk_destroy', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'DELETE_MEDICINES'
    example.metadata[:rpdoc_action_name] = '刪除多個抗過敏藥'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @medicines = create_list(:medicine, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @path = '/api/v1/medicines'
  end

  describe 'Delete medicines' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功刪除資料'

      params = {
        medicine_ids: @medicines.pluck(:id).sample(5)
      }

      delete(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)

      expect(Medicine.find_by(id: params[:medicine_ids])).to eq(nil)
    end
  end
end
