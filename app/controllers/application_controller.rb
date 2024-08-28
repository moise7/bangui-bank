class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # for now I can skip the authentication but I will need to figure out how this work
  skip_before_action :verify_authenticity_token
  def after_sign_out_path_for(resource)
    "/users/sign_in"
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    user_dashboard_path(resource) # Redirect to the user's dashboard after login
  end

  def after_sign_up_path_for(resource)
    user_dashboard_path(resource) # Redirect to the user's dashboard after sign-up
  end
end
