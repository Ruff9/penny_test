class AddIngredientsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :ingredients, :string, array:true, default: []
    add_index :recipes, :ingredients, using: 'gin'
  end
end
