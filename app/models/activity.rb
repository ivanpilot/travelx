class Activity < ApplicationRecord

  has_many :experiences
  has_many :users, through: :experiences

  # has_many :activity_categories
  # has_many :categories, through: :activity_categories
  #
  # has_many :board_activities
  # has_many :board, through: :board_activities

end
