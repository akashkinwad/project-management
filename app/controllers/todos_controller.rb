class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:edit, :update]
  before_action :find_project, except: :count_per_status
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :check_todos_authority!, only: [:edit, :update], if: -> { current_user.developer? }

  def index
    @todos = @project.todos
  end

  def show
  end

  def new
    @todo = @project.todos.new
  end

  def edit
  end

  def create
    @todo = @project.todos.new(todo_params)
    respond_to do |format|
      if @todo.save
        format.html { redirect_to project_todos_path(@project), notice: 'Todo was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to redirect_path, notice: 'Todo was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'Todo was successfully destroyed.' }
    end
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def find_project
      @project = Project.find(params[:project_id])
    end

    def todo_params
      params.require(:todo).permit(:description, :status, :user_id)
    end

    def check_todos_authority!
      unless @todo.user_id == current_user.id
        render_not_authorized_error
      end
    end

    def redirect_path
      if current_user.developer?
        user_path(current_user)
      else
        project_todos_path(@project)
      end
    end
end
