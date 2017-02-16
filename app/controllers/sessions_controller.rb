class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email:params[:user][:email])
    if user && user.try(:authenticate, params[:user][:password])
      @user = user
      log_in(@user)
      flash[:success] = "You are signed in."
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = "You are logged out."
    redirect_to root_path
  end

end
