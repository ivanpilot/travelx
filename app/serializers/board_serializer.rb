class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :is_authorized_edit_board, :is_authorized_destroy_board
  # belongs_to :user
  has_many :board_activities
  has_many :activities#, through: :board_activities

  def is_authorized_edit_board
    current_user = User.find_by(id: self.scope)
    user_visited = User.find_by(id: self.object.user_id)
    BoardPolicy.new(UserContext.new(current_user, user_visited), self.object).edit?
  end

  def is_authorized_destroy_board
    current_user = User.find_by(id: self.scope)
    user_visited = User.find_by(id: self.object.user_id)
    BoardPolicy.new(UserContext.new(current_user, user_visited), self.object).destroy?
  end

end
