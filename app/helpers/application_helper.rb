module ApplicationHelper

  def home(user)
    is_logged_in?(user) ? user_path(user) : root_path
  end

end
