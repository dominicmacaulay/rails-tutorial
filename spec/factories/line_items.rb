FactoryBot.define do
  factory :line_item do
    line_item_date { create(:line_item_date) }
    name { 'MyString' }
    description { 'MyText' }
    quantity { 5 }
    unit_price { 10 }
  end
end
