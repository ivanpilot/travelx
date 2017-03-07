class BoardActivityPolicy < ApplicationPolicy

  attr_reader :user, :board_activity, :friend

  def initialize(context, board_activity)
    @user = context.user
    @friend = context.friend
    @board_activity = board_activity
  end

  def destroy?
    true
    # is_owner? || (!friend.nil? && friend.activities.any? {|activity| activity.board_activities.include?(board_activity)} && user.admin?)
  end

  private

  def is_owner?
    user && board_activity.activity.user == user
  end


  # class Scope < Scope
  #   attr_reader :user, :scope, :friend
  #
  #   def initialize(context, scope)
  #     @user = context.user
  #     @friend = context.friend
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     # if user.admin?
  #     #   scope.all
  #     if !friend.nil? && (user.admin? || user.is_friend_with?(friend))
  #       scope.where(user: friend)
  #     else
  #       scope.where(user: user)
  #     end
  #   end
  # end

  # def create?
  #   true
  # end
  #
  # def show?
  #   is_owner? || (!friend.nil? && friend.boards.include?(board) && (user.is_friend_with?(friend) || user.admin?))
  # end
  #
  # def edit?
  #   is_owner? || (!friend.nil? && friend.boards.include?(board) && user.admin?)
  # end
  #
  # def update?
  #   edit?
  # end


end
