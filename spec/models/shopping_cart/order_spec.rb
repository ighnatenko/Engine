# frozen_string_literal: true

RSpec.describe ShoppingCart::Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:addresses) }
  it { is_expected.to have_one(:credit_card) }
  it { is_expected.to have_many(:positions) }
  it { is_expected.to have_many(:books) }
  it { is_expected.to belong_to(:delivery) }
  it { is_expected.to have_one(:coupon) }

  it { should validate_presence_of(:tracking_number) }
  it { should validate_presence_of(:state) }
end
