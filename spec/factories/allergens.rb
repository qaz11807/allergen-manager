FactoryBot.define do
  factory :allergen do
    sequence(:name) { |n| "test allergen - #{n}" }
  end
end
