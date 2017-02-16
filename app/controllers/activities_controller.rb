class ActivitiesController < ApplicationController
  before_action :authenticate_user, :reset_activities

  def index
    if params[:user_id] && correct_user?(params[:user_id])
      @activities = current_user.activities
      @activity = Activity.new
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def create
    # raise params.inspect
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.build(activity_params)

      if @activity.save
        flash[:success] = "New activity successfully created."
        redirect_to user_activities_path(current_user)
      else
        flash[:danger] = "Activity not created. Make sure you provide a description and a rating."
        redirect_to user_boards_path(current_user) #### MUST REDIRECT TO RIGHT URL
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def edit
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])
      store_previous_url
      if @activity.nil?
        flash[:danger] = "Activity not found."
        redirect_to user_boards_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def update
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])

      if !@activity.nil? && @activity.update(activity_params)
        flash[:success] = "Activity updated."
        go_to_previous_url
      else
        flash[:danger] = "Activity couldn't be found or updated."
        redirect_to user_boards_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def destroy
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])

      if !@activity.nil?
        @activity.destroy
        flash[:success] = "Activity deleted."
        redirect_to user_activities_path(current_user)
        @activity = nil
      else
        flash[:danger] = "Activity couldn't be found or updated."
        redirect_to user_activities_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating, :board_ids => [])
  end

  def reset_activities
    @activities = current_user.boards.select {|activity| activity.id}
  end



end
