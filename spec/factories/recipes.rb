FactoryBot.define do
  factory :recipe do
    sequence(:title) { |seq| "recipe_title_#{seq}" }
    author { 'Gordon Ramsay' }
    image_url { 'not/an/url' }
    prep_time { 20 }
    cook_time { 10 }
    ratings { 2.2 }

    after(:create) do |recipe|
      create(:ingredient, recipe:)
    end
  end
end
