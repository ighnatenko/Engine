module ShoppingCart
  # Address
  class Address < ApplicationRecord
    belongs_to :addressable, class_name: 'ShoppingCart::Address', polymorphic: true
    validates :firstname, :lastname, :address, :zipcode, :city,
              :country, :phone, :address_type, presence: true
    enum address_type: %i[billing shipping]
  end
end
