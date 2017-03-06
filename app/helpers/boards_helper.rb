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

  def display_create_activity_form_from_board(object) ####MUST BE MODIFIED IF ADMIN CREATE
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h3,"Start by creating an #{object.wordify} or ...")
      form_for object, :url => activities_path do |f|
        concat render :partial => "activities/activity_inline", :locals => {activity: f}
        concat f.submit "Create Activity", class:"btn btn-primary"
      end
      #  tag("br")
      # concat(tag 'br')
    end
  end

  def display_create_board_form(object)
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h3,"... Create a #{object.wordify}")
      concat content_tag(:h5,"Create your #{object.wordify} and add somes activities to it!")
      form_for object do |f|
        concat render :partial => "board", :locals => {board: f}
        concat render :partial => "fields_for", :locals => {f: f, wrapper: @board.activities.build(user_id:current_user.id)}
        # fields_for(@activities, object.activities.build(user_id:current_user.id)) do |ff|
        #   # concat ff.hidden_field :user_id
        #   render(partial: "activities/activity_inline", :locals => {activity: ff})
        # end
        concat f.submit "Create Board", class:"btn btn-primary"
      end
    end
  end

  def show_board_link(board, user_visited)
    link_to(board.title, board_link(board, user_visited)) if policy(board).show?
  end

  def board_link(board, user_visited)
    user_visited.nil? ? board_path(board) : user_board_path(user_visited, board)
  end
  # link_to board.title, board_path(board)

end
