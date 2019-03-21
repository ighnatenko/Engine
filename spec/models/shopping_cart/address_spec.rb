# frozen_string_literal: true

module ShoppingCart
  RSpec.describe Address, type: :model do
    it { is_expected.to belong_to(:addressable) }
  end
end
