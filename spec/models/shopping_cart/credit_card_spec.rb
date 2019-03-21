# frozen_string_literal: true

RSpec.describe ShoppingCart::CreditCard, type: :model do
  it { should belong_to(:order) }
end
