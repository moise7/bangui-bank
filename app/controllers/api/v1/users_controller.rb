# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:user_data]

  # GET /api/v1/users
  def index
    @users = User.select(:email, :created_at, :username, :balance).map do |user|
      user.as_json.merge(
        balance: format('%.2f', user.balance)  # Format balance to two decimal places
      )
    end
    render json: @users
  end

  # GET /api/v1/user_data
  def user_data
    if current_user
      render json: {
        user: {
          email: current_user.email,
          created_at: current_user.created_at,
          username: current_user.username,
          balance: format('%.2f', current_user.balance)
        }
      }
    else
      render json: { message: "User not authenticated.", user: nil }, status: :unauthorized
    end
  end

  # POST /api/v1/signup
  def create
    user = User.new(user_params)

    if user.save
      token = user.generate_token  # Ensure this method exists and generates a token

      render json: {
        message: "User created successfully.",
        user: {
          email: user.email,
          username: user.username,
          token: token
        }
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
