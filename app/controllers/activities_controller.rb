class ActivitiesController < ApplicationController
  before_action :authenticate_user

  def edit
    # @activity = Activity.find_by(id: params[:id])
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if !@user.nil? && correct_user?(@user)
        @activity = @user.activities.find_by(id: params[:id])

        if @activity.nil?
          flash[:danger] = "Activity not found."
          redirect_to user_boards_path(@user)
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
          # flash[:danger] = "Activity not found."
          # redirect_to user_boards_path(@user)
          # if
          flash[:success] = "Activity updated."
          redirect_to user_boards_path(@user)
            # redirect_to board_path(@activity.board) #TO BE CHANGEDDDDD to maintain url including user
        else
          flash[:danger] = "Activity couldn't be found or updated."
          redirect_to user_boards_path(@user)
        end
      else
        redirect_to user_boards_path(current_user)
      end
    end
    # @activity = Activity.find_by(id: params[:id])
    # if @activity.update(activity_params)
    #   flash[:success] = "Board updated."
    #   redirect_back(fallback_location: root_path)
    #   redirect_to board_path(@activity.board) #TO BE CHANGEDDDDD to maintain url including user
    # else
    #   flash.now[:alert] = "Board couldn't be updated."
    #   render :edit
    # end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating)
  end

end
