class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :is_logged_in?, :current_user?, :correct_user?
  include SessionsHelper
  include UsersHelper
  include FriendshipsHelper
  # include BoardActivitiesHelper

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

  def current_user?(user)
    current_user == user
  end

  def correct_user?(params_user)
    user = User.find_by(id: params_user)
    current_user?(user)
  end

  def store_previous_url
    session[:previous_url] = request.referrer
  end

  def go_to_previous_url
    redirect_to session[:previous_url]
  end


end
