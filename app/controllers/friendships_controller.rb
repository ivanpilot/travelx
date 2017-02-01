class FriendshipsController < ApplicationController
  before_action :authenticate_user

  def create
    # raise params.inspect
    new_friend = User.find_by(username: friendship_params[:friend])
    if new_friend
      new_friendship = Friendship.new(user_id: current_user.id, friend_id: new_friend.id)
      if new_friendship.save
        flash[:success] = "you added a new friend"
      else
        flash[:warning] = "there was an error"
      end
    end
    redirect_to friends_user_path(current_user)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend)
  end

end
