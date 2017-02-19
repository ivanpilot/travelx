module ActivitiesHelper

  def boards_related_to(activity)
    if activity.boards.empty?
      "No board"
    else
      activity.boards.collect do |board|
        link_to(board.title, boards_path(board))
      end.join(" | ").html_safe
    end
  end
  
end
