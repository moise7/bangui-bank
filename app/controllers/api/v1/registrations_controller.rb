class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(sign_up_params)

    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: { user: user.as_json(only: [:id, :username]), token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
