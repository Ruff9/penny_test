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

    it 'filters recipes by ingredients', :focus do
      recipe1 = create :recipe, title: 'Pancakes'
      create :ingredient, content: 'Brown sugar', recipe: recipe1

      recipe2 = create :recipe, title: 'French fries'
      create :ingredient, content: 'Potatoes', recipe: recipe2
      create :ingredient, content: 'salt', recipe: recipe2

      recipe3 = create :recipe, title: 'Tomato soup'
      create :ingredient, content: 'salt', recipe: recipe3

      visit recipes_path

      check 'potato'
      check 'salt'
      click_button 'Filter recipes'

      expect(page).to have_content('French fries')
      expect(page).not_to have_content('Pancakes')
      expect(page).not_to have_content('Tomato soup')
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
