# app/controllers/api/v1/registrations_controller.rb
class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { user: user, token: user.generate_jti }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password)
  end
end
