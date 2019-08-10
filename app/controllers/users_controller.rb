class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: :show

  def index
    @admins = User.admin
    @developers = User.developer
  end

  def show
    @user = User.find(params[:id])
    if current_user.admin?
      @todos = @user.todos.includes(:project).order(created_at: :desc)
    else
      @todos = current_user.todos.includes(:project).order(created_at: :desc)
    end
    unless current_user.admin? || @user == current_user
      render_not_authorized_error
    end
  end

end
