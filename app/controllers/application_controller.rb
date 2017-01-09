class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include UsersHelper

  def authenticate_user
    unless is_logged_in?(current_user)
      flash[:warning] = "Please sign in."
      redirect_to sign_in_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: params[:id]) if session.include?(:user_id)
  end
  helper_method :current_user

end
