class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :amount
      t.string :unit
      t.string :content
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
