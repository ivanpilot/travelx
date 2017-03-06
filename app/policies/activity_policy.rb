class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope, :friend

    def initialize(context, scope)
      @user = context.user
      @friend = context.friend
      @scope = scope
    end

    def resolve
      if !friend.nil? && (user.admin? || user.is_friend_with?(friend))
        scope.where(user: friend)
      else
        scope.where(user: user)
      end
    end
  end

  attr_reader :user, :activity, :friend

  def initialize(context, activity)
    @user = context.user
    @friend = context.friend
    @activity = activity
  end

  def create?
    true
  end

  def edit?  ###make the route is /users/:id/activities/:id/edit for admin and activity belongs to the right friend
    is_owner? || (!friend.nil? && friend.activities.include?(activity) && user.admin?)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end


  private

  def is_owner?
    user && activity.user == user
  end

end
