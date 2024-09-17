class ApplicationController < ActionController::Base
  # Disable CSRF protection for API requests
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect to sign-in page after signing out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Permit additional parameters for user sign-up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name, :date_of_birth, :town, :country, :phone_number, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :middle_name, :last_name, :date_of_birth, :town, :country, :phone_number, :password, :password_confirmation, :current_password])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
  end

  # Redirect to user's or admin's dashboard after signing in or signing up
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin) # Assuming `Admin` is your admin model
      admin_root_path
    else
      user_dashboard_path
    end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(Admin) # Assuming `Admin` is your admin model
      admin_root_path
    else
      user_dashboard_path
    end
  end

   # JWT Authentication
  def authenticate_user!
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    begin
      decoded_token = JwtService.decode(token)
      @current_user = User.find_by(id: decoded_token["user_id"], jti: decoded_token["jti"])
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
