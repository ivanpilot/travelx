class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :test
  # belongs_to :user
  has_many :board_activities
  has_many :activities#, through: :board_activities

  def test
    "hello"
  end

end
