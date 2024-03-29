class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  rescue_from(ActionController::RoutingError, with: :not_found)

  def not_found
  	 render :text => 'This is a custom 404.'
  end
end
