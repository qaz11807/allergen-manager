class Api::V1::AllergenEntity < BaseEntity
  expose :id, :name
  expose :created_at, :updated_at
end
