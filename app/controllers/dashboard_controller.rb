class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      Rails.logger.debug "User is authenticated"
    else
      Rails.logger.debug "User is not authenticated"
    end
    # Dashboard logic here
  end
end
