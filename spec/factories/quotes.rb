FactoryBot.define do
  factory :quote do
    company { create(:company) }
    name { 'Sample quote' }
  end
end
