class TasksController < ApplicationController

  before_action :set_task, only: [:edit, :update, :destroy]

  def create
    @task = Task.new(task_params)
    if @task.save
      calculate_progress
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @task.update(task_params)
      calculate_progress
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    @task.destroy
    calculate_progress
    respond_to do |format|
      format.turbo_stream
    end
  end

  def index
    calculate_progress
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def calculate_progress
    @tasks = Task.all
    @completed_tasks = Task.where(status: "Completed")
    @completed_width_percent = (@completed_tasks.count.to_f / @tasks.count * 100).round(2)
    @remaining_width_percent = 100 - @completed_width_percent
  end
end
