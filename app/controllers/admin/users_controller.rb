class Admin::UsersController < ApplicationController
  before_action :authenticate_user, :admin_user

  def index
    @users = User.all
  end





end
