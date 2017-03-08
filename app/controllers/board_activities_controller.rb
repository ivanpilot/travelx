class BoardActivitiesController < ApplicationController
  before_action :authenticate_user, :authenticate_friend

  def destroy
    @board_activity = BoardActivity.find_by(id: params[:id])
    if @board_activity
      authorize @board_activity
      @board_activity.destroy
      flash[:success] = "Activity deleted from the board."
      @board_activity = nil
    else
      flash[:danger] = "Activity couldn't be found or deleted."
    end
    redirect_back(fallback_location: to_boards)
  end

  private

  def to_boards
    if params[:user_id].nil?
      boards_path
    else
      user = User.find_by(id: params[:user_id])
      user_boards_path(user)
    end
  end

end
