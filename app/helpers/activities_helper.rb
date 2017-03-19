module ActivitiesHelper

  def url_address_create_activity(user_visited)
    user_visited.nil? ? activities_path : user_activities_path(user_visited)
  end

  def url_address_activity(activity, user_visited)
    user_visited.nil? ? activity_path(activity) : user_activity_path(user_visited, activity)
  end

  def edit_activity_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    user_visited.nil? ? edit_activity_path(activity) : edit_user_activity_path(user_visited, activity)
  end

  def delete_activity_link(activity, user_visited) ###TO BE USED NOT ONLY FOR ACTIVITY
    user_visited.nil? ? activity_path(activity) : user_activity_path(user_visited, activity)
  end

end
