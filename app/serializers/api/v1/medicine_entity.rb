class Api::V1::MedicineEntity < BaseEntity
  expose :id, :name, :manufacture, :description, :expired_at

  expose :icon_info, using: Api::V1::ImageEntity do |medicine|
    medicine.image
  end

  expose :created_at, :updated_at
end
