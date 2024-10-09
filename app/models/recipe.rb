class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  scope :filtered_by_ingredients, lambda { |ingredient_list|
    if ingredient_list.present?
      joins(:ingredients).where('ingredients.content ~* ?', ingredient_list)
    else
      all
    end
  }
end
