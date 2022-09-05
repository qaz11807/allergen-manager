FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    confirmed_at { Time.zone.now }
    profile { FactoryBot.build(:profile) }
    password { 'testtest' }
  end
end