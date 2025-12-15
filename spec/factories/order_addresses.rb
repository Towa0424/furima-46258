FactoryBot.define do
  factory :order_address do
    token         {"tok_abcdefghijk00000000000000000"}
    postal_code   { format("%03d-%04d", rand(0..999), rand(0..9999)) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address_line  { Faker::Address.street_address }
    phone         { "0" + format("%0*d", [9, 10].sample, rand(10**10)) }
  end
end
