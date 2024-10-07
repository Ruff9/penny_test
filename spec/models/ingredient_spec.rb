require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it { should belong_to(:recipe) }
  it { should belong_to(:food_item) }
end
