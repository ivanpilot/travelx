module ActivitiesHelper
  # include Display::InstanceMethods

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
      concat content_tag(:h2,"Create a new #{object.wordify.capitalize}")
      form_for object do |f|
        concat render :partial => "#{object.wordify}", :locals => {object.wordify.to_sym => f}
        concat f.submit "Create #{object.wordify.capitalize}", class:"btn btn-primary"
      end
    end
  end

end
