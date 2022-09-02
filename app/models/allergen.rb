class Allergen < ApplicationRecord
  belongs_to :user

  has_many :allergen_medicines, dependent: :destroy
  has_many :medicines, -> { distinct }, through: :allergen_medicines

  scope :not_in, proc { |allergen_ids| where.not(id: allergen_ids) }

  def unlinked_(allergen_id)
    allergen = allergens.find_by(id: allergen_id)
    medicines - allergen.medicnes
  end
end
