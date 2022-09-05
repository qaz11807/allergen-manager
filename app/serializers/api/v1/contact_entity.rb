class Api::V1::ContactEntity < BaseEntity
  expose :id, :name, :phone, :description
  expose :created_at, :updated_at
end
