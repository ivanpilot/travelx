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

  def display_form(object)
    # if DisplayPolicy.new(pundit_user, object).show?
    if policy(:display).show?
      concat content_tag(:h2,"Create a new #{object.class.name.downcase}")
      form_for object do |f|
        concat render partial:"activity", :locals => {activity: f}
        concat f.submit "Create Activity", class:"btn btn-primary"
      end
    end
  end

end
