class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # raise params.inspect
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully signed up"
      redirect_to user_path(@user)
    else
      flas.short[:alert] = "There was an issue during the sign up process"
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
