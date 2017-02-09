class WelcomeController < ApplicationController

  def index
    if is_logged_in?
      redirect_to user_boards_path(current_user)
    end
  end

end
