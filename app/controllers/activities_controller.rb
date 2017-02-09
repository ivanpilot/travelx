class ActivitiesController < ApplicationController

  before_action :authenticate_user

  def edit
    @activity = Activity.find_by(id: params[:id])
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    if @activity.update(activity_params)
      flash[:success] = "Board updated."
      redirect_to board_path(@activity.board) #TO BE CHANGEDDDDD to maintain url including user
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
