# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_cart_order, class: 'ShoppingCart::Order' do
    summary_price { rand(100..200) }
    state { 'in_progress' }
    tracking_number { "R#{Time.now.strftime('%d%m%y%H%M%S')}" }
    total_price { rand(100..200) }
    use_billing { false }
    association :delivery, factory: :shopping_cart_delivery
    user

    trait :with_coupon do
      association :coupon, factory: :shopping_cart_coupon
    end
  end
end
