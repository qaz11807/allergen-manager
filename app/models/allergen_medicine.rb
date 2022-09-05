class AllergenMedicine < ApplicationRecord
  belongs_to :allergen
  belongs_to :medicine
end
