FactoryBot.define do
  factory :medicine do
    sequence(:name) { |n| "test allergen - #{n}" }
    manufacture { 'kdan' }
    description { 'this is description' }
    expired_at { Time.now + 1.day }
  end
end
