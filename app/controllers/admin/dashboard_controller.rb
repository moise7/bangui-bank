class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin! # Ensure the admin is authenticated

  def index
    @users = User.all
    @recent_payments = Payment.order(created_at: :desc).limit(10) # Adjust as needed
  end
end
