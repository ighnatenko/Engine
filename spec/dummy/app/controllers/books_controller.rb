# frozen_string_literal: true

# BooksController
class BooksController < ApplicationController
  def show
    @book = Book.first
    @book = @book.decorate
  end
end
