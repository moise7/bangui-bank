# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # Override the default destroy action
  def destroy
    Rails.logger.info "Attempting to log out user: #{current_user.inspect}"
    super
  end

  private

  # Custom response for successful login
  def respond_with(_resource, _opts = {})
    Rails.logger.info "User logged in successfully: #{current_user.inspect}"
    render json: {
      message: 'You are logged in.',
      user: current_user
    }, status: :ok
  end

  # Custom response for logout
  def respond_to_on_destroy
    if user_signed_in?
      log_out_failure
    else
      log_out_success
    end
  end

  # Custom logout success response
  def log_out_success
    Rails.logger.info "Logout success: No user signed in."
    render json: { message: 'You are logged out.' }, status: :ok
  end

  # Custom logout failure response
  def log_out_failure
    Rails.logger.info "Logout failure: User still signed in: #{current_user.inspect}"
    render json: { message: 'Hmm, nothing happened.' }, status: :unauthorized
  end
end
