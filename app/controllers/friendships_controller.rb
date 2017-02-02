class FriendshipsController < ApplicationController
  before_action :authenticate_user

  def create
    new_friend = User.find_by(username: friendship_params[:friend])
    if new_friend && current_user.potential_friends.include?(new_friend)
      new_friendship = Friendship.create(user_id: current_user.id, friend_id: new_friend.id)
      flash[:success] = "You are now friends with #{new_friend.username}."
    else
      flash[:warning] = "There was an error."
    end
    redirect_to friends_user_path(current_user)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend)
  end

end
