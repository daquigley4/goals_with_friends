class TasksController < ApplicationController
  before_action :signed_in_user
  before_action :set_task, only: [:toggle_completed, :show, :edit, :update, :destroy]
  before_action :verify_correct_user, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @goal = Goal.find(params[:goal_id])
    @task = @goal.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    # @task.user = current_user
    # @goal = Goal.find(params[:id])
    @task.goal = Goal.find(params[:goal_id])   # associate the new task to the current_goal

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_goal_path(current_user, @task.goal), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_goal_path(current_user, @task.goal), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_goal_path(current_user, @task.goal), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_completed
    @task.completed = !@task.completed
    respond_to do |format|
      if @task.save
        format.html { redirect_to goals_path }
        format.json { render :show, status: :ok, location: @task }
      else
      # show some error message
      end
    end
  end

  def toggle_completed_task
    # @goal = Goal.find(params[:id])
    @goal = Goal.find(params[:goal_id])
    @task = Task.find(params[:id])
    @task.completed = !@task.completed
    respond_to do |format|
      if @task.save
        format.html { redirect_to user_goal_path(current_user, @task.goal) }
        format.json { render :show, status: :ok, location: @task }
      else
      # show some error message
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end

    def verify_correct_user
      puts "params: #{params}"
      puts "current_user.id: #{current_user.id}"
      if (current_user.id != params[:user_id].to_i)
        redirect_to root_url, notice: 'Access Denied - Wrong User!'
      else
        goal = current_user.goals.find(params[:goal_id])
        if (goal.nil?)
          redirect_to root_url, notice: 'Access Denied - Wrong Goal!'
        end
        task = goal.tasks.find(params[:id])
        if (task.nil?)
          redirect_to root_url, notice: 'Access Denied - Wrong Task!'
        end
      end
    end
end
