module ActivitiesHelper

  def boards_related_to(activity)
    if activity.boards.empty?
      "No board"
    else
      activity.boards.collect do |board|
        link_to(board.title, board_path(board))
      end.join(" | ").html_safe
    end
  end

  def form_activities(activity)
    form_for activity do |f|
      concat render partial:"activity", :locals => {activity: f}
      concat f.submit "Create Activity", class:"btn btn-primary"
    end
  end

end
