FactoryBot.define do
  factory :ingredient do
    content { 'sand' }
    amount { '2' }
    unit { 'kg' }
    recipe
  end
end
