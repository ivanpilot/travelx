class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :description, :rating#, :manual
  # belongs_to :user
  # has_many :board_activities
  # has_many :boards, through: :board_activities

  def manual
    "#{self}"
  end

end
