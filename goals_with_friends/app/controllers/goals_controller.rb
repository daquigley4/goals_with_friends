class GoalsController < ApplicationController

HELLOOOOO

  before_action :signed_in_user
  before_action :set_goal, only: [:toggle_completed, :show, :edit, :update, :destroy]
  before_action :verify_correct_user, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = current_user.goals.order(created_at: :desc)
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    @goal = Goal.find(params[:id])
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user   # associate the new goal to the current_user

    respond_to do |format|
      if @goal.save
        format.html { redirect_to user_goals_path(current_user), notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to user_goals_path(current_user), notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to user_goals_path(current_user), notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_completed
    @goal.completed = !@goal.completed
    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path }
        format.json { render :show, status: :ok, location: @goal }
      else
        # show some error message
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:title, :due_date, :completed)
    end

    def verify_correct_user
       @goal = current_user.goals.find_by(id: params[:id])
       redirect_to root_url, notice: 'Access Denied!' if @goal.nil?
    end
end
