class BoardActivitySerializer < ActiveModel::Serializer
  attributes :id, :board_id, :activity_id
  belongs_to :board
  # belongs_to :activity
end
