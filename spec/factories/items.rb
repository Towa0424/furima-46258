FactoryBot.define do
  factory :item do

    title                  { Faker::Commerce.product_name }
    description            { Faker::Lorem.sentence }
    category_id            { Faker::Number.between(from: 2, to: 11) }
    condition_id           { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_burden_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id          { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id        { Faker::Number.between(from: 2, to: 4) }
    price                  { Faker::Number.between(from: 300, to: 9_999_999) } 
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/furima_test.png'), filename: 'furima_test.png')
    end

    association :user
  end
end
