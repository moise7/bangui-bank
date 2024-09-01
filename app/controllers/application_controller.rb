class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_admin
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect to sign-in page after signing out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Permit additional parameters for user sign-up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # Redirect to user's dashboard after signing in or signing up
  def after_sign_in_path_for(resource)
    user_dashboard_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_dashboard_path(resource)
  end

  # Admin helpers
  helper_method :current_admin, :admin_logged_in?

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def admin_logged_in?
    current_admin.present?
  end

  def authenticate_admin!
    redirect_to new_admin_session_path unless admin_logged_in?
  end
end
