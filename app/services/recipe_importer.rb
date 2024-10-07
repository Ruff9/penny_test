module RecipeImporter
  class << self
    def perform(source_file)
      recipes_data = JSON.parse(source_file)

      recipes_data.each do |recipe_data|
        recipe = build_recipe(recipe_data)

        recipe_data['ingredients'].each do |ingredient_data|
          recipe.ingredients << build_ingredient(ingredient_data)
        end

        recipe.save!
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

    def build_ingredient(ingredient_data)
      parsed_data = Ingreedy.parse(ingredient_data)
      food_item = FoodItem.find_or_create_by(title: parsed_data.ingredient)

      Ingredient.new(
        food_item:,
        amount: parsed_data.amount,
        unit: parsed_data.unit
      )
    end
  end
end
