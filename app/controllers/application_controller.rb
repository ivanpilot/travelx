class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :is_logged_in?
  include SessionsHelper
  include UsersHelper
  include FriendshipsHelper

  def authenticate_user
    unless is_logged_in?
      flash[:warning] = "Please sign in."
      redirect_to sign_in_path
    end
  end

  def is_logged_in?
    !!current_user
  end


  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session.include?(:user_id)
  end


end
