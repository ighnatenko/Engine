# frozen_string_literal: true

module FeatureHelper
  def fill_address(type, address)
    fill_in("address_#{type}_form_firstname", with: address.firstname)
    fill_in("address_#{type}_form_lastname", with: address.lastname)
    fill_in("address_#{type}_form_address", with: address.address)
    fill_in("address_#{type}_form_city", with: address.city)
    fill_in("address_#{type}_form_zipcode", with: address.zipcode)
    select('Ukraine', from: "address_#{type}_form_country")
    fill_in("address_#{type}_form_phone", with: address.phone)
  end

  def fill_card(card)
    fill_in('payment_number', with: card[:number])
    fill_in('payment_card_name', with: card[:card_name])
    fill_in('payment_expiration_date', with: card[:expiration_date])
    fill_in('payment_cvv', with: card[:cvv])
  end

  def stup_current_order(order)
    allow_any_instance_of(ShoppingCart::ApplicationController)
      .to receive(:current_order).and_return(order)
  end

  def stub_current_user(user)
    allow_any_instance_of(ShoppingCart::ApplicationController)
      .to receive(:current_user).and_return(user)
  end
end
