class User < ApplicationRecord

  before_save :email_downcase
  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, unless: Proc.new { |a| a.password.blank? }
  validates :password_confirmation, presence: true, unless: Proc.new { |a| a.password.blank? }

  has_secure_password

  has_many :activities
  has_many :boards
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inversed_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inversed_friends, through: :inversed_friendships, source: :user

  def all_friends
    self.friends + self.inversed_friends
  end

  def potential_friends
    User.all_other_users(self) - self.all_friends
  end

  def self.all_other_users(user)
    where.not(id: user.id)
  end

  def all_relationships
    Friendship.where(user_id: self.id) + Friendship.where(friend_id: self.id)
  end

  def owns_board?(board)
    self.boards.include?(board)
  end

  def switch_role
    self.role == "user" ? self.role = "admin" : self.role = "user"
    self.save
  end

  def admin?
    self.role == "admin"
  end

  def is_friend_with?(friend)
    self.all_friends.include?(friend)
  end

  private

  def email_downcase
    self.email = self.email.downcase
  end

end
