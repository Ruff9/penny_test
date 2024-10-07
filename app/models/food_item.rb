class FoodItem < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
