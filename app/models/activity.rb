class Activity < ApplicationRecord

  has_many :experiences, dependent: :destroy
  has_many :users, through: :experiences

  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

  belongs_to :board
end
