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
      expect(recipe1.ingredients).to include '1 cup all-purpose flour'

      recipe2 = Recipe.find_by(title: 'Monkey Bread I')

      expect(recipe2.cook_time).to eq 35
      expect(recipe2.prep_time).to eq 15
      expect(recipe2.author).to eq 'deleteduser'
      expect(recipe2.ratings).to eq 4.74

      expect(recipe2.ingredients.count).to eq 7
      expect(recipe2.ingredients).to include '½ cup chopped walnuts'
    end

    it "don't import existing recipe" do
      Recipe.create(title: 'Unique recipe title')

      source_file = load_test_file('existing_recipe')

      expect { RecipeImporter.perform(source_file) }.not_to change(Recipe, :count)
    end
  end
end
