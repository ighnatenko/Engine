# frozen_string_literal: true

RSpec.describe ShoppingCart::PaymentForm, type: :model do
  %i[number cvv expiration_date card_name].each do |attribute|
    it { is_expected.to validate_presence_of(attribute) }
  end
end
