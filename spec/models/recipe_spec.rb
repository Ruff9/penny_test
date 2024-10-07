require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { should have_many(:ingredients).dependent(:destroy) }
  it { should have_many(:food_items).through(:ingredients) }

  it { should validate_presence_of(:title) }
end
