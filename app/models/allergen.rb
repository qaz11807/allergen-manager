class Allergen < ApplicationRecord
  belongs_to :user

  has_many :allergen_medicines, dependent: :destroy
  has_many :medicines, -> { distinct }, through: :allergen_medicines
end
