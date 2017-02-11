class Activity < ApplicationRecord

  # validates :board_id, presence: false

  # has_many :experiences, dependent: :destroy
  # has_many :users, through: :experiences
  belongs_to :user, optional: true
  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

  has_many :board_activities, dependent: :destroy
  has_many :boards, through: :board_activities
  # belongs_to :board
end
