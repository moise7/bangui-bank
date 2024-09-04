class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def profile
    render json: current_user.as_json(only: [:id, :name, :email])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def add_money
    @user = User.find(params[:id])
  end

  def update_balance
    @user = User.find(params[:id])
    amount = params[:amount].to_f

    if amount > 0
      @user.deposit(amount)
      redirect_to admin_root_path, notice: 'Money added successfully.' # Changed from admin_dashboard_path to admin_root_path
    else
      redirect_to admin_root_path, alert: 'Invalid amount.' # Changed from admin_dashboard_path to admin_root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :balance) # Add other user attributes as needed
  end
end
