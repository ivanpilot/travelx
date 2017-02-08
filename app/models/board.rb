class Board < ApplicationRecord

  belongs_to :user
  has_many :activities

  accepts_nested_attributes_for :activities

end
