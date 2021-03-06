module BoardActivitiesHelper

  def show_boardactivity_delete_link(board, activity, user_visited)
    board_activity = board_activity_instance(board, activity)
    link_to("| Delete", delete_boardactivity_link(board_activity, user_visited), class: "delete-board-activity", method: :delete, data: {confirm: 'This will delete the activity from the board only. Are you sure?'}) if policy(board_activity).destroy?
  end

  def board_activity_instance(board, activity)
    BoardActivity.find_board_activity(board, activity)
  end

  def board_activity_id(board, activity)
    self.board_activity_instance(board, activity).id
  end

  def delete_boardactivity_link(boardactivity, user_visited)
    user_visited.nil? ? board_activity_path(boardactivity) : user_board_activity_path(user_visited, boardactivity)
  end

end
