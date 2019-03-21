module ApplicationHelper
  def quantity_book_in_cart
    return 0 unless @current_order.in_progress?
    @current_order.books.count
  end
end
