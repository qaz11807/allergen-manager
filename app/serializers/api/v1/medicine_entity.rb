class Api::V1::MedicineEntity < BaseEntity
  expose :id, :name, :manufacture, :description, :expired_at
  expose :created_at, :updated_at
end
