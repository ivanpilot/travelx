class WelcomeController < ApplicationController

  def index
    redirect_to boards_path unless is_logged_in?
  end

end
