# frozen_string_literal: true

# CustomerController
class CustomerController < ApplicationController
  def index
    redirect_to :new_user_session
  end
end
