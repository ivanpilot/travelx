class ActivitiesController < ApplicationController

  before_action :authenticate_user

  def edit
    @activity = Activity.find_by(id: params[:id])
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    @user = User.find_by(id: "1") #TO BE CHANGEDDDDD
    if @activity.update(activity_params)
      flash[:success] = "Board updated."
      redirect_to user_boards_path(@user) #TO BE CHANGEDDDDD
    else
      flash.now[:alert] = "Board couldn't be updated."
      render :edit
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :rating)
  end

end
