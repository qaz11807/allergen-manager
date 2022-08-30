# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#destroy', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'DELETE_ALLERGEN'
    example.metadata[:rpdoc_action_name] = '刪除過敏原'
    example.metadata[:rpdoc_example_folders] = ['Allergens']

    @allergen = create(:allergen, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}"
    }
    @path = '/api/v1/allergens'
  end

  describe 'Destroy allergens' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功刪除資料'

      delete("#{@path}/#{@allergen.id}", headers: @headers)
      expect(response).to have_http_status(:ok)

      expect(Allergen.find_by(id: @allergen.id)).to eq(nil)
    end

    it 'should return code 404' do |example|
      example.metadata[:rpdoc_example_key] = '404'
      example.metadata[:rpdoc_example_name] = '更新資料失敗(找不到過敏原)'

      delete("#{@path}/123456", headers: @headers)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_0002)
    end
  end
end
