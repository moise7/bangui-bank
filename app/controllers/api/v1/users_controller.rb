# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user! # Add this if you need authentication

  # GET /api/v1/users
  def index
    # Pagination (if needed)
    # page = params[:page] || 1
    # per_page = params[:per_page] || 10
    # @users = User.select(:email, :created_at, :username, :balance)
    #              .paginate(page: page, per_page: per_page)

    @users = User.select(:email, :created_at, :username, :balance).map do |user|
      user.as_json.merge(
        balance: format('%.2f', user.balance)  # Format balance to two decimal places
      )
    end

    render json: @users
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find_by(id: params[:id])

    if @user
      render json: {
        message: "You are logged in.",
        user: {
          email: @user.email,
          created_at: @user.created_at,
          username: @user.username,
          balance: format('%.2f', @user.balance)
        }
      }
    else
      render json: { message: "User not found.", user: nil }, status: :not_found
    end
  end

end
