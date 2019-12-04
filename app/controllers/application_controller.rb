class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  alias_method :current_user, :current_staff

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :full_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])


  end



end
