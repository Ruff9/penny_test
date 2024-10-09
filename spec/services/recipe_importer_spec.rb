require 'rails_helper'

def load_test_file(name)
  File.read(File.expand_path("../test_data/#{name}.json", __FILE__))
end

RSpec.describe RecipeImporter do
  before(:each) do
    allow_any_instance_of(ProgressBar::Output).to receive(:stream).and_return(double.as_null_object)
  end

  describe '#perform' do
    it 'import json seed to database' do
      source_file = load_test_file('two_recipes')

      RecipeImporter.perform(source_file)

      recipe1 = Recipe.find_by(title: 'Golden Sweet Cornbread')

      expect(recipe1.cook_time).to eq 25
      expect(recipe1.prep_time).to eq 10
      expect(recipe1.author).to eq 'bluegirl'
      expect(recipe1.ratings).to eq 4.74

      expect(recipe1.ingredients.count).to eq 8

      food_item1 = FoodItem.find_by(title: 'all-purpose flour')
      ingredient1 = recipe1.ingredients.find_by(food_item: food_item1)

      expect(ingredient1.amount).to eq '1'
      expect(ingredient1.unit).to eq 'cup'

      recipe2 = Recipe.find_by(title: 'Monkey Bread I')

      expect(recipe2.cook_time).to eq 35
      expect(recipe2.prep_time).to eq 15
      expect(recipe2.author).to eq 'deleteduser'
      expect(recipe2.ratings).to eq 4.74
      expect(recipe2.ingredients.count).to eq 7

      food_item2 = FoodItem.find_by(title: 'chopped walnuts')
      ingredient2 = recipe2.ingredients.find_by(food_item: food_item2)

      expect(ingredient2.amount).to eq '1/2'
      expect(ingredient2.unit).to eq 'cup'
    end

    it "don't import existing recipe" do
      Recipe.create(title: 'Unique recipe title')

      source_file = load_test_file('existing_recipe')

      expect { RecipeImporter.perform(source_file) }.not_to change(Recipe, :count)
    end
  end
end
