FactoryBot.define do
  factory :food_item do
    sequence(:title) { |seq| "food_item_title_#{seq}" }
  end
end
