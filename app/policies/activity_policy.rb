class ActivityPolicy < ApplicationPolicy

  def index?
    user.admin? || record.try(:user) == user
  end

  def create?
    user.admin? || record.try(:user) == user
  end

end
