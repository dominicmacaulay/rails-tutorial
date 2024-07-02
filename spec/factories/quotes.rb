FactoryBot.define do
  factory :quote do
    company { create(:kpmg) }
    name { 'Sample quote' }
  end
end
