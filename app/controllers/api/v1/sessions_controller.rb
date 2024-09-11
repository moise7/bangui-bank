# app/controllers/api/v1/sessions_controller.rb
class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(username: session_params[:username])

    if user && user.valid_password?(session_params[:password])
      jti = SecureRandom.uuid  # Generate a unique identifier for the JWT
      token = JwtService.encode(user_id: user.id, jti: jti) # Include the new jti in the token

      # Update the user's jti in the database
      user.update(jti: jti)

      render json: { user: user.as_json(only: [:id, :username]), token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    # Handle the logout process if required
    head :no_content
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
