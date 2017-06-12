class BoardSerializer < ActiveModel::Serializer
  attributes :id#, :title
  # belongs_to :user
  # has_many :board_activities
  # has_many :activities, through: :board_activities
end
