# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/allergens#bulk_destroy', type: :request do
  include_context 'rpdoc'

  before(:each) do |example|
    example.metadata[:rpdoc_action_key] = 'DELETE_ALLERGENS'
    example.metadata[:rpdoc_action_name] = '刪除多個過敏原'
    example.metadata[:rpdoc_example_folders] = ['Allergens']

    @allergens = create_list(:allergen, 10, user: @user)

    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      allergen_ids: @allergens.pluck(:id).sample(5)
    }
    @path = '/api/v1/allergens'
  end

  describe 'Delete allergens' do
    it 'should return code 200' do |example|
      example.metadata[:rpdoc_example_key] = '200'
      example.metadata[:rpdoc_example_name] = '成功刪除資料'

      delete(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)

      expect(Allergen.find_by(id: @params[:allergen_ids])).to eq(nil)
    end
  end
end
