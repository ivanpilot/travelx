class Board < ApplicationRecord

  include Display::InstanceMethods

  validates :title, presence: true#, message: "Please provide a title to create a new board."

  belongs_to :user
  has_many :board_activities, dependent: :destroy
  has_many :activities, through: :board_activities

  # accepts_nested_attributes_for :activities, reject_if: :reject_activities

  #RAILS HELPER VERSION WITHOUT AJAX IMPLEMENTED
  # def activities_attributes=(attributes)
  #   attributes.values.each do |attribute|
  #     if attribute.values.none? {|att| att.blank?}
  #       activity = Activity.find_by_activity_des_and_user_id(attribute[:description], attribute[:user_id])
  #       new_activity = activity.nil? ? Activity.create!(attribute) : activity
  #       self.activities << new_activity
  #     end
  #   end
  # end

  #VERSION WITH AJAX
  def activities_attributes=(attributes)
    attributes.each do |attribute|
      if attribute.values.none? {|att| att.blank?}
        activity = Activity.find_by_activity_des_and_user_id(attribute[:description], attribute[:user_id])
        new_activity = activity.nil? ? Activity.create!(attribute) : activity
        self.activities << new_activity
      end
    end
  end

  def self.find_by_board_title_and_user_id(board_title, user_id)
    self.where('user_id = ? AND lower(title) = lower(?)', user_id, board_title.downcase).first
  end

  # def reject_activities(attributes)
  #   attributes['description'].blank? && attributes['rating'].blank?
  # end

  # def error_title
  #   errors[:title] = "Provide a title to create a new board."
  # end

end
