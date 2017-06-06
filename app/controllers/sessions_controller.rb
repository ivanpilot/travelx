class SessionsController < ApplicationController
  layout "welcome"

  def new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_by_omniauth(auth_hash)
      log_in(@user)
      flash[:success] = "You are signed in."
      redirect_to root_path
    else
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
  end

  def destroy
    log_out
    flash[:success] = "You are logged out."
    redirect_to root_path
  end

  def auth
    request.env['omniauth.auth']
  end

end
