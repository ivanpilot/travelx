class BoardactivitySerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :board
  # belongs_to :activity
end
