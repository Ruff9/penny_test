class RecipesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @recipes = pagy(Recipe.all)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
