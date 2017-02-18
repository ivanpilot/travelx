class Admin::UsersController < ApplicationController
  before_action :authenticate_user, :admin_user

  def index
    @users = User.all
  end

  private

  def admin_user
    unless is_admin?
      flash[:warning] = "Please sign up."
      redirect_to sign_in_path
    end
  end

  def is_admin?
    !!current_user.admin? if current_user
  end

end
