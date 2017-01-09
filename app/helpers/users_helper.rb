module UsersHelper

  def correct_user(user)
    unless current_user?(user)
      flash[:warning] = "Please sign in."
      redirect_to sign_in_path
    end
  end

  def current_user?(user)
    current_user == user
  end

end
