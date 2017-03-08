module ActivitiesHelper

  def display_create_activity_form(object,user_visited) ####MUST BE MODIFIED IF ADMIN CREATE
    if policy(:display).show? #DisplayPolicy.new(pundit_user, object).show?
      concat content_tag(:h2,"Create a new #{object.wordify.capitalize}")
      form_for object, :url => url_address_create_activity(user_visited) do |f|
        concat render :partial => "#{object.wordify}", :locals => {object.wordify.to_sym => f}
        concat f.submit "Create #{object.wordify.capitalize}", class:"btn btn-primary"
      end
    end
  end

  # def display_edit_form(object, user_visited)
  #   concat content_tag(:h2,"Update your #{object.wordify.capitalize}")
  #   form_for object, :url => url_address(object, user_visited) do |f|
  #     concat render :partial => "#{object.wordify}", :locals => {object.wordify.to_sym => f}
  #     concat f.submit "Update #{object.wordify.capitalize}", class:"btn btn-primary"
  #   end
  # end

  def url_address_create_activity(user_visited)
    user_visited.nil? ? activities_path : user_activities_path(user_visited)
  end

  def url_address_activity(activity, user_visited)
    user_visited.nil? ? activity_path(activity) : user_activity_path(user_visited, activity)
  end

  def show_activity_edit_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    link_to("| Edit", edit_activity_link(activity, user_visited)) if policy(activity).edit?
  end

  def edit_activity_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    user_visited.nil? ? edit_activity_path(activity) : edit_user_activity_path(user_visited, activity)
  end

  def show_activity_delete_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    link_to("| Delete", delete_activity_link(activity, user_visited),method: :delete, data: {confirm: 'Are you sure?'}) if policy(activity).destroy?
  end

  def delete_activity_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    user_visited.nil? ? activity_path(activity) : user_activity_path(user_visited, activity)
  end

end
