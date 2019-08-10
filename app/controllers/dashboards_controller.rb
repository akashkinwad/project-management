class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @projects = Project.includes(:todos).all
  end

end
