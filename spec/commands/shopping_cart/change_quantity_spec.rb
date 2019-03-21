require 'spec_helper'

RSpec.describe ShoppingCart::ChangeQuantity do
  let(:order) { create :shopping_cart_order }
  let(:book) { create :book }

  it 'broadcasts :empty_position' do
    command = ShoppingCart::ChangeQuantity.new(
      order.id, book.id, increment: true
    )
    expect { command.call }.to broadcast(:empty_position)
  end

  it 'broadcasts :ok' do
    ShoppingCart::Position.create(book: book, order: order, quantity: 2)

    command = ShoppingCart::ChangeQuantity.new(
      order.id, book.id, increment: true
    )
    expect { command.call }.to broadcast(:ok)
  end
end
