class ActivitiesController < ApplicationController
  before_action :authenticate_user

  def index
    if params[:user_id] && correct_user?(params[:user_id])
      @activities = current_user.activities
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
        render :index
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def edit
    if params[:user_id] && correct_user?(params[:user_id])
      @activity = current_user.activities.find_by(id: params[:id])

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
        redirect_to user_boards_path(current_user)#TO BE CHANGEDDDDD to previous url
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
        @activity.delete
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
    params.require(:activity).permit(:description, :rating)
  end

end
