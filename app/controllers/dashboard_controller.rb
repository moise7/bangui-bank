class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # Dashboard logic here
  end
end
