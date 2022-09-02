FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "contacter - #{n}" }
    phone { '000-123-456' }
    description { 'this is the description' }
  end
end
