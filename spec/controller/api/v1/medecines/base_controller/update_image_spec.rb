# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#update_image', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'UPDATE_MEDICINE_IMAGE'
    example.metadata[:rpdoc_action_name] = '更新抗過敏藥圖片'
    example.metadata[:rpdoc_example_folders] = ['Api', 'V1', 'Medicines']

    @medicine = create(:medicine, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'multipart/form-data'
    }
    @path = "/api/v1/medicines/#{@medicine.id}/image"
  end

  describe 'Update medicine image' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功更新資料'

      file = fixture_file_upload('medicine_icon.jpeg', 'image/jpeg')
      params = {
        image: file
      }

      put(@path,  headers: @headers, params: params)
      expect(response).to have_http_status(:ok)

      @medicine.reload
      expect(@medicine.image.file.attached?).to eq(true)
    end
  end
end
