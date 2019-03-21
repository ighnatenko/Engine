FactoryBot.define do
  factory :shopping_cart_delivery, class: 'ShoppingCart::Delivery' do
    title { Faker::Book.title }
    days { 'test' }
    price { rand(10...20) }
  end
end
