FactoryBot.define do
  factory :user do
    company { create(:company) }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
  end
end
