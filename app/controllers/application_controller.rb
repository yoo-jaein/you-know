class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  add_flash_types :danger, :info, :warning, :success, :dark, :secondary
  
  protected
  
  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end
  
  private
  
  
  # If your model is called User
  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end
  
  
end
