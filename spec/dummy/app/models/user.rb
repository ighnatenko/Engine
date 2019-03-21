# frozen_string_literal: true

# User
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, class_name: 'ShoppingCart::Order', dependent: :destroy
  has_many :addresses, as: :addressable, class_name: 'ShoppingCart::Address', dependent: :destroy
end
