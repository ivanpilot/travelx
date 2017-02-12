class ActivitiesController < ApplicationController
  before_action :authenticate_user

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if !@user.nil? && correct_user?(@user)
        @activities = @user.activities
      else
        redirect_to user_boards_path(current_user)
      end
    end
  end

  def edit
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if !@user.nil? && correct_user?(@user)
        @activity = @user.activities.find_by(id: params[:id])

        if @activity.nil?
          flash[:danger] = "Activity not found."
          redirect_to user_boards_path(current_user)
        end
      else
        redirect_to user_boards_path(current_user)
      end
    end
  end

  def update
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if !@user.nil? && correct_user?(@user)
        @activity = @user.activities.find_by(id: params[:id])

        if !@activity.nil? && @activity.update(activity_params)
          flash[:success] = "Activity updated."
          redirect_to user_boards_path(@user)#TO BE CHANGEDDDDD to previous url
        else
          flash[:danger] = "Activity couldn't be found or updated."
          redirect_to user_boards_path(current_user)
        end
      else
        redirect_to user_boards_path(current_user)
      end
    end
  end

  def destroy
    # raise params.inspect
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if !@user.nil? && correct_user?(@user)
        @activity = @user.activities.find_by(id: params[:id])

        if !@activity.nil?
          @activity.delete
          @activity = nil
          flash[:success] = "Activity deleted."
          redirect_to user_boards_path(@user)
        else
          flash[:danger] = "Activity couldn't be found or updated."
          redirect_to user_boards_path(current_user)
        end
      else
        redirect_to user_boards_path(current_user)
      end
    end

  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating)
  end

end
