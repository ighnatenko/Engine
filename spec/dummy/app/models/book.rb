# frozen_string_literal: true

# Book
class Book < ApplicationRecord
  has_many :positions, class_name: 'ShoppingCart::Position'
  has_many :orders, through: :positions, dependent: :destroy

  validates :title, :price, :materials, presence: true
  validates :height, :width, :depth,
            numericality: { greater_than_or_equal_to: 0 }
  validates :publication_year,
            numericality: { less_than_or_equal_to: Time.current.year }
end
