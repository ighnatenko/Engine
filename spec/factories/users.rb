FactoryBot.define do
  factory :user, class: ShoppingCart.user_class do
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
