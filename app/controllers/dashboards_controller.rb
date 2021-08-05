class DashboardsController < ApplicationController
  before_action :authorize_admin!

  def index
    @projects = Project.includes(:todos).all
  end

end
