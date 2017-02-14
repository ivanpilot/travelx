class BoardActivity < ApplicationRecord

  belongs_to :board
  belongs_to :activity

  def self.find_board_activity(board, activity)
    self.where(board_id:board.id, activity_id:activity.id).first
  end

  def is_correct?(user, board, activity)
    user.boards.include?(self.board) && user.activities.include?(self.activity)
  end
end
