module FriendshipsHelper

  def delete_friendship(friendship)
    friendship.delete
    friendship = nil
  end

end
