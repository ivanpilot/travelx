class ActivityPolicy < ApplicationPolicy

  attr_reader :user, :activity, :friend

  def initialize(context, activity)
    @user = context.user
    @friend = context.friend
    @activity = activity
  end
  #
  # def index?
  #
  # end
  #
  #
  #
  class Scope < Scope

    attr_reader :user, :scope, :friend

    def initialize(context, scope)
      @user = context.user
      @friend = context.friend
      @scope = scope
    end

    def resolve
      if user.admin?# || user.is_friend_with?(friend)
        scope.all
      elsif user.is_friend_with?(friend)
        scope.where(user: friend)
      else
        scope.where(user: user)
      end
    end

  end

end
