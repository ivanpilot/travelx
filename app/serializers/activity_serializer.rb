class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :description, :rating, :authorized_activity?
  # belongs_to :user
  # has_many :board_activities
  # has_many :boards, through: :board_activities

  #

end
