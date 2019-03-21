# frozen_string_literal: true

RSpec.describe ShoppingCart::Position, type: :model do
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:order) }

  it { should validate_presence_of(:quantity) }
end
