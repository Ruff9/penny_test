require 'ruby-progressbar'

module RecipeImporter
  class << self
    def perform(source_file)
      recipes_data = JSON.parse(source_file)

      Parallel.each(recipes_data, in_processes: 4, progress: 'Importing') do |recipe_data|
        Recipe.transaction do
          next if Recipe.exists?(title: recipe_data['title'])

          recipe = build_recipe(recipe_data)
          build_ingredients(recipe, recipe_data['ingredients'])

          recipe.save!
        rescue Ingreedy::ParseFailed, Parallel::UndumpableException
          next
        end
      end
    end

    def build_recipe(recipe_data)
      Recipe.new(
        title: recipe_data['title'],
        prep_time: recipe_data['prep_time'],
        cook_time: recipe_data['cook_time'],
        author: recipe_data['author'],
        ratings: recipe_data['ratings'],
        image_url: recipe_data['image']
      )
    end

    def build_ingredients(recipe, ingredients_data)
      ingredients_data.each do |ingredient_data|
        recipe.ingredients << build_ingredient(ingredient_data)
      end
    end

    def build_ingredient(ingredient_data)
      parsed_data = Ingreedy.parse(ingredient_data)

      Ingredient.new(
        content: parsed_data.ingredient,
        amount: parsed_data.amount,
        unit: parsed_data.unit
      )
    end
  end
end
