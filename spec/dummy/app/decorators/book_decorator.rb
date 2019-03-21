# frozen_string_literal: true

# BookDecorator
class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions
    ["H: #{height}\"", "W: #{width}\"", "D: #{depth}\""].join(' x ')
  end

  def root_image
    'https://res.cloudinary.com/hs3woyk6w/image/upload/default'
  end

  def quantity_in_cart(order)
    ShoppingCart::Position.find_by(order_id: order.id, book_id: id).quantity
  end

  def total_price(order)
    quantity_in_cart(order) * price
  end
end
