class Recipe < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def self.filtered_by_ingredients(ingredient_list)
    if ingredient_list.present?
      query = ->(ingredient) { "array_to_string(ingredients, '||') ilike '%#{ingredient}%'" }

      result = Recipe.where(query.call(ingredient_list.first))
      ingredient_list.drop(1).map { |ingredient| result = result.where(query.call(ingredient)) }

      result
    else
      Recipe.all
    end
  end
end
