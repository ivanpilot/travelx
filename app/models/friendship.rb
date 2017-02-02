class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.connections_with(user)
    connections = self.where(user_id: user.id) && self.where(friend_id: user.id)
  end

end
