class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :author
      t.string :image_url
      t.integer :prep_time
      t.integer :cook_time
      t.float :ratings

      t.timestamps
    end
  end
end
