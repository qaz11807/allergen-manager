module Api
  module V1
    module Medicines
      class BaseValidator < BasicValidator
        def index
          param! :page,     Integer, default: 1
          param! :per_page, Integer
        end

        def create
          param! :name,         String,   required: true
          param! :manufacture,  String
          param! :description,  String
          param! :expired_at,   DateTime, required: true
        end

        def update
          param! :name,         String
          param! :manufacture,  String
          param! :description,  String
          param! :expired_at,   DateTime
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
