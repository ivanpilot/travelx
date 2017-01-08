class Category < ApplicationRecord

  has_many :activity_categories, dependent: :destroy
  has_many :categories, through: :activity_categories

end
