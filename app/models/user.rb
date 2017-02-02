class User < ApplicationRecord

  before_save :email_downcase
  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
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

  def connections
    self.friends + self.inversed_friends
  end

  def potential_friends
    User.all_other_users(self) - self.connections
  end

  def self.all_other_users(user)
    where.not(id: user.id)
  end


  private

  def email_downcase
    self.email = self.email.downcase
  end

end
