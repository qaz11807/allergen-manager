module Api
  module V1
    module Medicines
      class AllergensValidator < BasicValidator
        def index
          param! :page,     Integer, default: 1
          param! :per_page, Integer
          param! :linked,   TrueClass, default: true
        end

        def add
          param! :allergen_ids, Array do |array, index|
            array.param! index, Integer, required: true
          end
        end

        def remove
          param! :allergen_ids, Array do |array, index|
            array.param! index, Integer, required: true
          end
        end
      end
    end
  end
end
