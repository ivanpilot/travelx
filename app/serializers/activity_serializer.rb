class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :description, :rating, :is_authorized_edit_activity, :is_authorized_destroy_activity
  # belongs_to :user
  # has_many :board_activities
  # has_many :boards, through: :board_activities

  def is_authorized_edit_activity
    current_user = User.find_by(id: self.scope)
    user_visited = User.find_by(id: self.object.user_id)
    ActivityPolicy.new(UserContext.new(current_user, user_visited), self.object).edit?
  end

  def is_authorized_destroy_activity
    current_user = User.find_by(id: self.scope)
    user_visited = User.find_by(id: self.object.user_id)
    ActivityPolicy.new(UserContext.new(current_user, user_visited), self.object).destroy?
  end

end
