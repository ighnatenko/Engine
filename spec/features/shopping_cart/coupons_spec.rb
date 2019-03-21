# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Coupons', type: :feature do
  let(:coupon) { create(:shopping_cart_coupon) }

  before do
    @order = create(:shopping_cart_order).decorate
    @book = create(:book)
    create(:shopping_cart_position, order: @order, book: @book)

    stup_current_order(@order)
    visit shopping_cart.cart_path

    expect(page).to have_content(I18n.t('cart.cart'))
    expect(page).to have_content(I18n.t('cart.enter_coupon'))
  end

  scenario 'check order summary' do
    expect(page).to have_content(I18n.t('cart.order_summary'))
    expect(page).to have_content(I18n.t('cart.subtotal'))
    expect(page).to have_content(I18n.t('cart.coupon'))
    expect(page).to have_content(I18n.t('cart.order_total'))
  end

  scenario 'correctly calculated order summary' do
    expect(page).to have_css('#cart_subtotal', text: "€#{@order.subtotal}")
    expect(page).to have_css('#cart_coupon_discount', text: '€0')

    fill_in('coupon_code', with: coupon.code)
    click_button('apply_coupon_btn')

    expect(page).to have_css('#cart_coupon_discount', text:
      "€#{@order.coupon_discount}")
    expect(page).to have_css('#cart_order_total', text:
      "€#{@order.order_total}")

    expect(page.current_path).to eq shopping_cart.cart_path
  end

  scenario 'coupon successfully added' do
    fill_in('coupon_code', with: coupon.code)
    click_button('apply_coupon_btn')
    expect(page).to have_css('.alert-success', text: I18n.t('coupon.added'))
  end

  scenario 'coupon does not exist' do
    fill_in('coupon_code', with: 'wrong coupon code')
    click_button('apply_coupon_btn')
    expect(page).to have_css('.alert-danger', text: I18n.t('coupon.not_exist'))
  end
end
