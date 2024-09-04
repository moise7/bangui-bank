class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  respond_to :json


  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      render json: { token: current_user.authentication_token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: 'Signed out successfully' }, status: :ok
  end
end
