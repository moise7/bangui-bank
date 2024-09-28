class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:user_data]

  def user_data
    formatted_balance = format('%.2f', @current_user.balance)
    render json: {
      user: {
        email: @current_user.email,
        first_name: @current_user.first_name,
        middle_name: @current_user.middle_name,
        last_name: @current_user.last_name,
        date_of_birth: @current_user.date_of_birth,
        town: @current_user.town,
        country: @current_user.country,
        created_at: @current_user.created_at,
        username: @current_user.username,
        balance: formatted_balance,
        phone_number: @current_user.phone_number
      }
    }
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
            Rails.logger.error("Authentication failed: User not found or token is invalid")
            render json: { message: "User not authenticated." }, status: :unauthorized and return
          end
        else
          Rails.logger.error("Authentication failed: Invalid or expired token")
          render json: { message: "Token expired or invalid. Please log in again." }, status: :unauthorized and return
        end
      rescue JWT::ExpiredSignature
        Rails.logger.error("Authentication failed: Token has expired")
        render json: { message: "Your session has expired. Please log in again." }, status: :unauthorized and return
      rescue JWT::DecodeError => e
        Rails.logger.error("Authentication failed: #{e.message}")
        render json: { message: "Invalid token. Please log in again." }, status: :unauthorized and return
      end
    else
      Rails.logger.error("Authentication failed: No token provided")
      render json: { message: "No token provided. Please log in." }, status: :unauthorized
    end
  end
end
