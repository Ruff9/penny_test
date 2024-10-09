require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  describe 'index' do
    it 'lists recipes' do
      create :recipe, title: 'Best lasagna of all time'
      create :recipe, title: 'Mid lasagna'

      visit recipes_path

      expect(page).to have_content('Best lasagna of all time')
      expect(page).to have_content('Mid lasagna')
    end

    it 'allows to filter recipe by food_item' do
      recipe1 = create :recipe, title: 'Pancakes'
      food_item1 = create :food_item, title: 'Brown sugar'
      ingredient1 = create :ingredient, food_item: food_item1, recipe: recipe1

      recipe2 = create :recipe, title: 'French fries'
      food_item2 = create :food_item, title: 'Potatoes'
      ingredient2 = create :ingredient, food_item: food_item2, recipe: recipe2

      visit recipes_path

      check 'potato'
      click_button 'Filter recipes'

      expect(page).to have_content('French fries')
      expect(page).not_to have_content('Pancakes')
    end
  end

  describe 'show' do
    it 'displays data on a recipe' do
      recipe = create :recipe, title: 'Ultimate ravioli',
                               author: 'Linguini',
                               prep_time: 45,
                               cook_time: 10,
                               ratings: 4.5

      visit recipe_path(recipe)

      expect(page).to have_content('Ultimate ravioli')
      expect(page).to have_content('Linguini')
      expect(page).to have_content('45 minutes')
      expect(page).to have_content('10 minutes')
      expect(page).to have_content('4.5/5')
    end
  end
end
