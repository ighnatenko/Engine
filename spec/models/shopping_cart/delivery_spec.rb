# frozen_string_literal: true

RSpec.describe ShoppingCart::Delivery, type: :model do
  it { is_expected.to have_many(:orders) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:days) }
  it { should validate_presence_of(:price) }
end
