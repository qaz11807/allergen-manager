class Medicine < ApplicationRecord
  belongs_to :user

  has_many :allergen_medicines, dependent: :destroy
  has_many :allergens, -> { distinct }, through: :allergen_medicines
  has_one :image, as: :imagable

  scope :not_in, proc { |medicine_ids| where.not(id: medicine_ids) }

  def update_image(image_file)
    if image.nil?
      create_image(file: image_file)
    else
      image.file.purge
      image.file.attach(image_file)
    end
    image.generate_url!
  end
end
