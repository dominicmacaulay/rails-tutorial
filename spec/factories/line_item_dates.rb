FactoryBot.define do
  factory :line_item_date do
    quote { create(:quote) }
    date { Date.current }
  end
end
