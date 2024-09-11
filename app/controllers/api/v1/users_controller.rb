# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:user_data]

  def user_data
    if @current_user
      formatted_balance = format('$%.2f', @current_user.balance)
      render json: {
        user: {
          email: @current_user.email,
          created_at: @current_user.created_at,
          username: @current_user.username,
          balance: formatted_balance
        }
      }
    else
      render json: { message: "User not authenticated.", user: nil }, status: :unauthorized
    end
  rescue => e
    Rails.logger.error("Failed to fetch user data: #{e.message}")
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        decoded_token = JwtService.decode(token)
        if decoded_token && decoded_token[:user_id] && decoded_token[:jti]
          @current_user = User.find_by(id: decoded_token[:user_id], jti: decoded_token[:jti])
          unless @current_user
            Rails.logger.error("Authentication failed: User not found for the provided token")
            render json: { message: "User not authenticated." }, status: :unauthorized
          end
        else
          Rails.logger.error("Authentication failed: Invalid or expired token")
          render json: { message: "Token expired or invalid. Please log in again." }, status: :unauthorized
        end
      rescue => e
        Rails.logger.error("Authentication failed: #{e.message}")
        render json: { message: "Token expired or invalid. Please log in again." }, status: :unauthorized
      end
    else
      Rails.logger.error("Authentication failed: No token provided")
      render json: { message: "No token provided. Please log in." }, status: :unauthorized
    end
  end
end

