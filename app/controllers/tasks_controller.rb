class TasksController < ApplicationController
  before_action :require_user_logged_in?
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order('created_at DESC')
  end 
  
  def show
  end 
  
  def new
    @task = Task.new
  end 
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に登録されました、頑張って'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が登録されませんでした'
      render :new
    end 
  end 
  
  def edit
  end 
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました、頑張って'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end 
  end 
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました、お疲れ様でした'
    redirect_to tasks_url
  end 
  
  private
  
  def require_user_logged_in?
    unless logged_in?
    redirect_to login_url
    end 
  end 
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url if !@task
  end 
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end 