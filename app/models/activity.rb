class Activity < ApplicationRecord

  validates :description, presence: true
  validates :rating, presence: true

  # has_many :experiences, dependent: :destroy
  # has_many :users, through: :experiences
  belongs_to :user
  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

  has_many :board_activities
  has_many :boards, through: :board_activities
  # belongs_to :board
end
