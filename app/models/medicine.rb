class Medicine < ApplicationRecord
  belongs_to :user
  has_many :allergen_medicines, dependent: :destroy
  has_many :allergens, -> { distinct }, through: :allergen_medicines
  has_one :image, as: :imagable
end
