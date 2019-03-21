require 'spec_helper'

RSpec.describe ShoppingCart::UseCoupon do
  let(:order) { create :shopping_cart_order }

  let(:fail_params) do
    FactoryBot.attributes_for(:shopping_cart_coupon, code: 'not_exist')
  end

  let(:params) do
    FactoryBot.attributes_for(:shopping_cart_coupon, code: 'test-1')
  end

  it 'broadcasts :not_exist' do
    command = ShoppingCart::UseCoupon.new(fail_params, order)
    expect { command.call }.to broadcast(:not_exist)
  end

  it 'broadcasts :ok' do
    ShoppingCart::Coupon.create!(code: 'test-1', discount: 5)

    command = ShoppingCart::UseCoupon.new(params, order)
    expect { command.call }.to broadcast(:ok)
  end

  it 'broadcasts :already_used' do
    ShoppingCart::Coupon.create(code: 'test-1', discount: 5, order: order)

    command = ShoppingCart::UseCoupon.new(params, order)
    expect { command.call }.to broadcast(:already_used)
  end
end
