module Api
  module V1
    module Allergens
      class MedicinesValidator < BasicValidator
        def index
          param! :page,     Integer, default: 1
          param! :per_page, Integer
          param! :linked,   :boolean, default: true
        end

        def add
          param! :medicine_ids, Array do |array, index|
            array.param! index, Integer, required: true
          end
        end

        def remove
          param! :medicine_ids, Array do |array, index|
            array.param! index, Integer, required: true
          end
        end
      end
    end
  end
end
