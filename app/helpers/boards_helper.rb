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
        link_to(board.title, board_link(board, user_visited)) if policy(board).show?
      end.join(" | ").html_safe
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

  def board_link(board, user_visited)
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end

  def edit_board_link(board, user_visited) ###TO BE USED NOT ONLY FOR BOARD
    user_visited.nil? ? edit_board_path(board) : edit_user_board_path(user_visited, board)
  end

  def delete_board_link(board, user_visited) ###TO BE USED NOT ONLY FOR BOARD
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end


end
