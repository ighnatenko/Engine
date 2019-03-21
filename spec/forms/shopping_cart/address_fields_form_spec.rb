# frozen_string_literal: true

RSpec.describe ShoppingCart::AddressFieldsForm, type: :model do
  it 'validate fields of address form' do
    %i[firstname lastname address zipcode city
       country phone address_type].each do |attribute|
      should validate_presence_of(attribute)
    end
  end
end
