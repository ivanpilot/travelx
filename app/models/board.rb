class Board < ApplicationRecord

  belongs_to :user
  has_many :board_activities, dependent: :destroy
  has_many :activities, through: :board_activities

  accepts_nested_attributes_for :activities

end
