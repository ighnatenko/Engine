FactoryBot.define do
  factory :shopping_cart_coupon, class: 'ShoppingCart::Coupon' do
    code { "code-#{rand(1..10)}" }
    discount { rand(6..10) }
    order nil

    trait :invalid do
      code nil
    end

    trait :with_order do
      association :order, factory: :shopping_cart_order
    end
  end
end
