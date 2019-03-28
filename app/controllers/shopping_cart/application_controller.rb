module ShoppingCart
  class ApplicationController < ShoppingCart.parent_controller.constantize
    layout 'application'

    [CanCan::AccessDenied, ActiveRecord::RecordNotFound,
     ActionController::RoutingError].each do |error|
      rescue_from error do |exception|
        redirect_to main_app.root_path, alert: exception.message
      end
    end
  end
end
