FactoryBot.define do
  factory :shopping_cart_address, class: 'ShoppingCart::Address' do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    address { Faker::Address.street_name }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    country { 'LS' }
    phone { Faker::PhoneNumber.phone_number }

    trait :shipping do
      address_type :shipping
    end

    trait :billing do
      address_type :billing
    end
  end
end
