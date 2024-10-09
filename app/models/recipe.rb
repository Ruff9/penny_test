class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :food_items, through: :ingredients

  validates :title, presence: true, uniqueness: true
end
