FactoryBot.define do
  factory :category, class: Category do
    name_en { Faker::Lorem.word }
    name_th { Faker::Lorem.word }
  end

  factory :product, class: Product do
    title { Faker::Lorem.question }
    long_desc { Faker::Lorem.sentence }
    user_id { 1 }
    stock { Faker::Number.between(from: 50, to: 50000) }
    sold_quantity { Faker::Number.between(from: 0, to: 10) }
    price { Faker::Number.between(from: 50, to: 50000) }
    categories { [FactoryBot.create(:category)] }
  end

end