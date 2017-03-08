class BoardPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope, :friend

    def initialize(context, scope)
      @user = context.user
      @friend = context.friend
      @scope = scope
    end

    def resolve
      # if user.admin?
      #   scope.all
      if !friend.nil? && (user.admin? || user.is_friend_with?(friend))
        scope.where(user: friend)
      else
        scope.where(user: user)
      end
    end
  end

  attr_reader :user, :board, :friend

  def initialize(context, board)
    @user = context.user
    @friend = context.friend
    @board = board
  end

  def create?
    is_owner? || (!friend.nil? && user.admin?)
  end

  def show?
    is_owner? || (!friend.nil? && friend.boards.include?(board) && (user.is_friend_with?(friend) || user.admin?))
  end

  def edit?
    is_owner? || (!friend.nil? && friend.boards.include?(board) && user.admin?)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def is_owner?
    user && board.user == user
  end

end
