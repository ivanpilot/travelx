module ActivitiesHelper

  def boards_related_to(activity, user)
    if activity.boards.empty?
      "No board"
    else
      activity.boards.collect do |board|
        link_to(board.title, user_board_path(current_user, board))
      end.join(" | ").html_safe
    end
  end
end
