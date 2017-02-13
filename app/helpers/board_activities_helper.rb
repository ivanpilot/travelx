module BoardActivitiesHelper

  def board_activity_id(board, activity)
    BoardActivity.find_board_activity(board, activity).id
  end
end
