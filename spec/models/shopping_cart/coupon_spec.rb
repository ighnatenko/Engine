# frozen_string_literal: true

RSpec.describe ShoppingCart::Coupon, type: :model do
  context 'field validation' do
    it { should validate_presence_of(:discount) }
    it { validate_length_of(:code).is_at_most(6..10) }
  end

  context 'associations' do
    it { should belong_to(:order) }
  end
end
