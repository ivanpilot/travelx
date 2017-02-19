class ActivityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all if user.admin?
    end
  end

  def index?
    user.admin? #|| record.try(:user) == user
  end

  def create?
    # user.admin? ||
    record.try(:user) == user
  end

  def update?
    # user.admin? ||
    record.try(:user) == user
  end

end
