class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user&.valid_password?(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, user: @user }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    # Optionally handle logout logic if you want to manage token blacklisting
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
