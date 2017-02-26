class WelcomeController < ApplicationController

  def index
    redirect_to boards_path if is_logged_in?
  end

end
