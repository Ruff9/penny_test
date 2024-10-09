class RecipesController < ApplicationController
  include Pagy::Backend

  def index
    @base_ingredients = YAML.load_file("#{Rails.root}/seed_data/base_ingredients.yml")
    @selected_ingredients = (params[:ingredients].present? ? params[:ingredients] : [])

    @pagy, @recipes = pagy(Recipe.all.order(ratings: :desc))
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
