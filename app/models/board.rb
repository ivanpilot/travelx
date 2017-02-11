class Board < ApplicationRecord

  belongs_to :user
  belongs_to :activity
  # has_many :activities
  # has_many :board_activities
  # has_many :activities, through: :board_activities

  # accepts_nested_attributes_for :activities

end
