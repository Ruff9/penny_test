FactoryBot.define do
  factory :ingredient do
    amount { '2' }
    unit { 'kg' }
    recipe
    food_item
  end
end
