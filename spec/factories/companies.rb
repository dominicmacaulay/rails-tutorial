FactoryBot.define do
  factory :company do
    name { 'my company' }
  end

  trait :kpmg do
    name { 'KPMG' }
  end

  trait :pwc do
    name { 'PwC' }
  end
end
