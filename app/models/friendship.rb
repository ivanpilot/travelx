class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.connections_with(user)
    connections = self.where(user_id: user.id) + self.where(friend_id: user.id)
  end

  def friend_of(current_user)
    self.user == current_user ? self.friend : self.user
  end

  def friend_name_of(current_user)
    self.user == current_user ? self.friend.username : self.user.username
  end

end
