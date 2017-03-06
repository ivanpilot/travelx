class Board < ApplicationRecord

  include Display::InstanceMethods

  validates :title, presence: true#, message: "Please provide a title to create a new board."

  belongs_to :user
  has_many :board_activities, dependent: :destroy
  has_many :activities, through: :board_activities

  accepts_nested_attributes_for :activities, reject_if: :reject_activities

  # def activities_attributes=(attributes)
  # end

  def reject_activities(attributes)
    attributes['description'].blank? && attributes['rating'].blank?
  end

  # def error_title
  #   errors[:title] = "Provide a title to create a new board."
  # end

end
