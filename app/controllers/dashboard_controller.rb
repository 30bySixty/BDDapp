class DashboardController < ApplicationController
  def index
#    @athletes = User.all
    @athletes = User.paginate(:page => params[:page])
  end
end
