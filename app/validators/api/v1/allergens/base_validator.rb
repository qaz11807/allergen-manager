module Api
  module V1
    module Allergens
      class BaseValidator < BasicValidator
        def index
          param! :page,     Integer, default: 1
          param! :per_page, Integer
        end

        def create
          param! :name, String, required: true
        end

        def update
          param! :name, String
        end

        def bulk_destroy
          param! :allergen_ids, Array do |array, index|
            array.param! index, Integer, required: true
          end
        end
      end
    end
  end
end
