module BoardActivitiesHelper

  def boards_related_to(activity)
    if activity.boards.empty?
      "No board"
    else
      activity.boards.collect do |board|
        link_to(board.title, board_path(board))
      end.join(" | ").html_safe
    end
  end

  def board_activity_id(board, activity)
    BoardActivity.find_board_activity(board, activity).id
  end
end
