class Activity < ApplicationRecord

  validates :description, presence: true
  validates :rating, presence: true

  # has_many :experiences, dependent: :destroy
  # has_many :users, through: :experiences
  belongs_to :user
  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

  has_many :board_activities
  has_many :boards, through: :board_activities
  # belongs_to :board

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


end
