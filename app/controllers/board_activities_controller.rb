class BoardActivitiesController < ApplicationController
  before_action :authenticate_user

  def destroy
    board_activity = BoardActivity.find_by(id: params[:id])
    if board_activity.is_correct?(current_user, board_activity.board, board_activity.activity)
      board_activity.delete
      flash[:success] = "Activity deleted."
      redirect_to user_board_path(current_user, board_activity.board)
      board_activity = nil
    else
      flash[:danger] = "Activity couldn't be found or updated."
      redirect_to user_boards_path(current_user)
    end
  end

end
