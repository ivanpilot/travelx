class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email:params[:user][:email])
    if user && user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "You are signed in."
      redirect_to user_path(user)
    else
      flash.now[:danger] = "The combination email/password is not valid."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are logged out."
    redirect_to root_path
  end

end
