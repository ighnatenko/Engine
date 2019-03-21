module ShoppingCart
  # Coupon
  class Coupon < ApplicationRecord
    belongs_to :order, optional: true, class_name: 'ShoppingCart::Order'
    validates :code, uniqueness: true
    validates :code, length: { in: 6..10 }
    validates :discount, presence: true
  end
end
