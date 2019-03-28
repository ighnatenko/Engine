# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let!(:user) { create(:user) }
  let!(:delivery) { create(:shopping_cart_delivery) }
  let!(:order) { create(:shopping_cart_order, user: user) }
  let!(:book) { create(:book) }

  background do
    create(:shopping_cart_position, order: order, book: book)
    stub_current_user(user)
    visit(shopping_cart.checkout_index_path)
  end

  context 'addresses' do
    scenario 'check elements on address page' do
      expect(page).to have_css('h1.general-title-margin', text: I18n.t('checkout.checkout'))
      expect(page).to have_css('h3.general-subtitle', text: I18n.t('checkout.billing_address'))
      expect(page).to have_css('p.general-info-text', text: I18n.t('checkout.required'))
      expect(page).to have_css('h3.general-subtitle', text: I18n.t('checkout.shipping_address'))
      expect(page).to have_css('span.checkbox-text', text: I18n.t('checkout.use_billing_adress'))
      expect(page).to have_selector('.btn.btn-default.center-block.mb-20')
      expect(page).to have_selector('#new_address_')
    end

    scenario 'filling addresses' do
      fill_address(:billing, build(:shopping_cart_address))
      fill_address(:shipping, build(:shopping_cart_address))
      click_button(I18n.t('checkout.save'))
      expect(page).to have_css('.general-subtitle', text: I18n.t('cart.credit_card.title'))
    end
  end

  context 'delivery' do
    background do
      order.addresses.billing.create(attributes_for(:shopping_cart_address))
      order.addresses.shipping.create(attributes_for(:shopping_cart_address))
      visit(shopping_cart.checkout_path(:delivery))
    end

    scenario 'check elements on delivery page' do
      expect(page).to have_css('.general-subtitle', text: I18n.t('cart.credit_card.title'))
      expect(page).to have_css('.radio-text', text: delivery.title)
      expect(page).to have_css('span', text: delivery.days)
      expect(page).to have_css('span', text: delivery.price)
      expect(page).to have_css('.btn.btn-default.mb-20')
    end

    scenario 'choosing delivery method' do
      first('.hidden-xs .radio-text').click
      find('#deliveries-submit-btn').click
      expect(page).to have_css('.general-subtitle', text: I18n.t('cart.credit_card.title'))
    end
  end

  context 'payment' do
    background do
      order.addresses.billing.create(attributes_for(:shopping_cart_address))
      order.addresses.shipping.create(attributes_for(:shopping_cart_address))
      order.update(delivery: delivery)
      visit(shopping_cart.checkout_path(:payment))
    end

    scenario 'check elements on payment page' do
      expect(page).to have_css('.general-subtitle', text: I18n.t('cart.credit_card.title'))
      expect(page).to have_selector('input.form-control', count: 4)
      expect(page).to have_css('.btn.btn-default.center-block.mb-20')
    end

    scenario 'filling payment' do
      fill_card(attributes_for(:shopping_cart_credit_card))
      click_button(I18n.t('checkout.save'))
      ['Billing Address', 'Shipping Address', 'Shipments', 'Payment Information'].each do |content|
        expect(page).to have_content(content)
      end
    end
  end

  context 'confirm' do
    background do
      order.addresses.billing.create(attributes_for(:shopping_cart_address))
      order.addresses.shipping.create(attributes_for(:shopping_cart_address))
      order.update(delivery: delivery)
      create(:shopping_cart_credit_card, order: order)
      visit(shopping_cart.checkout_path(:confirm))
    end

    scenario 'check elements on payment page' do
      ['Billing Address', 'Shipping Address', 'Shipments', 'Payment Information'].each do |content|
        expect(page).to have_content(content)
      end
    end

    scenario 'check order items presence' do
      order.books.each do |item|
        expect(page).to have_css('span', text: item.positions.first.quantity)
        expect(page).to have_css('.title', text: item.title)
      end
    end

    scenario 'check addresses presence ' do
      order.addresses.each do |address|
        expect(page).to have_content("#{address.firstname} #{address.lastname}")
        expect(page).to have_content(address.address)
        expect(page).to have_content("#{address.city} #{address.zipcode}")
        expect(page).to have_content(address.country)
        expect(page).to have_content("Phone #{address.phone}")
      end
    end

    scenario 'confirming' do
      find('.btn.btn-default.mb-20.conf').click
      expect(page).to have_content('Thank You for your Order!')
    end
  end
end
