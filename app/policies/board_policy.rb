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
    true
  end

  def show?
    user.admin? || is_owner? || user.is_friend_with?(friend)
  end

  def edit?
    true
    # is_owner? || (!friend.nil? && user.admin?)
  end

  # def update?
  #   user.admin? || is_owner?
  # end
  #
  def destroy?
    is_owner? || (!friend.nil? && user.admin?)
  end


  private

  def is_owner?
    user && board.user == user
  end

end
