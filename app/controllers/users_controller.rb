class UsersController < ApplicationController
  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "You have successfully signed up."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def update
    if correct_user?(params[:id])
      current_user.alternate_role
      redirect_back(fallback_location: session[:previous_url])
      flash[:success] = "You changed your role."
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def friends
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
