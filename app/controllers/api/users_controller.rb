# app/controllers/api/users_controller.rb
class Api::UsersController < ApplicationController
  before_action :authenticate_user! # Add this if you need authentication

  def index
    # Select only the necessary fields and format the balance
    @users = User.select(:email, :created_at, :username, :balance).map do |user|
      user.as_json.merge(
        balance: format('%.2f', user.balance)  # Format balance to two decimal places
      )
    end

    render json: @users
  end

  def show
    @user = User.find(params[:id])

    # Format balance to two decimal places
    render json: {
      email: @user.email,
      created_at: @user.created_at,
      username: @user.username,
      balance: format('%.2f', @user.balance) # Format balance to two decimal places
    }
  end
end
