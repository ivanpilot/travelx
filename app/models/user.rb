class User < ApplicationRecord

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  has_secure_password

  has_many :experiences, dependent: :destroy
  has_many :activities, through: :experiences
  has_many :boards
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inversed_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inversed_friends, through: :inversed_friendships, source: :user



end
