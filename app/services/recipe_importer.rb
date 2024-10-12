require 'ruby-progressbar'

module RecipeImporter
  class << self
    def perform(source_file)
      recipes_data = JSON.parse(source_file)

      Parallel.each(recipes_data, in_processes: 4, progress: 'Importing') do |recipe_data|
        Recipe.transaction do
          next if Recipe.exists?(title: recipe_data['title'])

          recipe = build_recipe(recipe_data)
          add_ingredients(recipe, recipe_data['ingredients'])

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

    def add_ingredients(recipe, ingredients_data)
      ingredients_data.each do |ingredient_data|
        recipe.ingredients << ingredient_data
      end
    end
  end
end
