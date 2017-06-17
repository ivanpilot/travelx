class Activity < ApplicationRecord

  include Display::InstanceMethods

  validates :description, presence: true
  validates :rating, presence: true

  belongs_to :user
  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

  has_many :board_activities, dependent: :destroy
  has_many :boards, through: :board_activities

  def board_ids=(ids)
    self.boards_reset
    ids.each do |id|
      if !id.empty?
        board = Board.find_by(id:id)
        self.boards << board
      end
    end
  end

  def boards_reset
    self.board_activities.each do |board_activity|
      board_activity.delete
    end
  end

  def self.find_by_activity_des_and_user_id(activity_description, user_id)
    self.where('user_id = ? AND lower(description) = lower(?)', user_id, activity_description.downcase).first
  end

  def authorized_activity?
    # show_me_policy = Pundit.policy(self.user_id, self)
    # show_me_scope = Pundit.policy_scope(self.user_id, self)
    # "policy is #{show_me_policy} and scope is #{show_me_scope}"
  end

end
