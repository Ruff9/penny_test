class CreateFoodItems < ActiveRecord::Migration[7.2]
  def change
    create_table :food_items do |t|
      t.string :title

      t.timestamps
    end
  end
end
