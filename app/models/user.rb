class User < ApplicationRecord

  has_secure_password

  has_many :experiences, dependent: :destroy
  has_many :activities, through: :experiences
  has_many :boards
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inversed_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inversed_friends, through: :inversed_friendships, source: :user

end
