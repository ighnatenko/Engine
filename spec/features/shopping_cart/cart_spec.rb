# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cart', type: :feature do
  scenario 'cart is not empty' do
    book = create(:book).decorate
    order = create(:shopping_cart_order, books: [book])

    stup_current_order(order)
    visit shopping_cart.cart_path

    expect(page).to have_content(book.title)
    expect(page).to have_content("€#{book.price}")
  end

  scenario 'cart is empty' do
    order = create(:shopping_cart_order)

    stup_current_order(order)
    visit shopping_cart.cart_path

    expect(page).to have_content('Empty cart')
  end
end
