class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Rails.logger.debug "Received params: #{params.inspect}"

    # Change user lookup to use username instead of email
    user = User.find_by(username: session_params[:username])

    if user&.valid_password?(session_params[:password])
      token = generate_token(user)
      render json: { user: user.as_json(only: [:id, :username]), token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def session_params
    # Adjust the params to permit the username instead of email
    params.permit(:username, :password)
  end

  def generate_token(user)
    # Ensure this method generates a valid JWT token
    JwtService.encode(user_id: user.id)
  end
end
