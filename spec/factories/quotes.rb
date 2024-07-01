FactoryBot.define do
  factory :quote do
    name { 'Sample quote' }
  end
  factory :first_quote, parent: :quote do
    name { 'First quote' }
  end
  factory :second_quote, parent: :quote do
    name { 'Second quote' }
  end
  factory :third_quote, parent: :quote do
    name { 'Third quote' }
  end
end
