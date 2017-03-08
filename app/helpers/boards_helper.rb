module BoardsHelper

  def errors_messages(object)
    if object.errors.any?
       content_tag(:div, nil, :id=>"error_explanation") do
        content_tag(:div, class:"alert alert-danger") do
          content_tag(:ul) do
            object.errors.full_messages.each do |msg|
              concat content_tag(:li, "#{msg}")
            end.join.html_safe
          end
        end
      end
    end
  end

  def boards_related_to(activity, user_visited)
    if activity.boards.empty?
      "No board"
    else
      activity.boards.collect do |board|
        show_board_link(board, user_visited)
      end.join(" | ").html_safe
    end
  end

  def display_create_activity_form_from_board(object, user_visited) ####MUST BE MODIFIED IF ADMIN CREATE
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h3,"Start by creating an #{object.wordify} or ...")
      form_for object, :url => url_address_create_activity(user_visited) do |f|
        concat render :partial => "activities/activity_inline", :locals => {activity: f}
        concat f.submit "Create Activity", class:"btn btn-primary"
      end
      #  tag("br")
      # concat(tag 'br')
    end
  end

  def display_create_board_form(object, user_visited)
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h3,"... Create a #{object.wordify}")
      concat content_tag(:h5,"Create your #{object.wordify} and add somes activities to it!")
      form_for object, :url => url_address_create_board(user_visited) do |f|
        concat render :partial => "board", :locals => {board: f}
        concat render :partial => "fields_for", :locals => {f: f, wrapper: @board.activities.build(user_id:right_user_id(user_visited))}
        # fields_for(@activities, object.activities.build(user_id:current_user.id)) do |ff|
        #   # concat ff.hidden_field :user_id
        #   render(partial: "activities/activity_inline", :locals => {activity: ff})
        # end
        concat f.submit "Create Board", class:"btn btn-primary"
      end
    end
  end

  def display_edit_board(object, user_visited)
    form_for object, :url => url_address_board(object, user_visited) do |f|
      concat render :partial => "board", :locals => {board: f}
      concat f.submit "Update", class: "btn btn-primary"
    end
  end

  def right_user_id(user_visited)
    user_visited.nil? ? current_user.id : user_visited.id
  end

  def url_address_create_board(user_visited)
    user_visited.nil? ? boards_path : user_boards_path(user_visited)
  end

  def url_address_board(board, user_visited)
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end

  def show_board_link(board, user_visited)
    link_to(board.title, board_link(board, user_visited)) if policy(board).show?
  end

  def board_link(board, user_visited)
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end

  def show_board_edit_button(board, user_visited)
    button_to("Edit title", edit_board_link(board, user_visited), :class => "btn btn-info", method: :get) if policy(board).edit?
  end

  def show_board_delete_button(board, user_visited)
    button_to("Delete board", delete_board_link(board, user_visited), :class => "btn btn-danger", method: :delete, data: {confirm: "Are you sure?"}) if policy(board).destroy?
  end

  def edit_board_link(board, user_visited) ###TO BE USED NOT ONLY FOR BOARD
    user_visited.nil? ? edit_board_path(board) : edit_user_board_path(user_visited, board)
  end

  def delete_board_link(board, user_visited) ###TO BE USED NOT ONLY FOR BOARD
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end


end
