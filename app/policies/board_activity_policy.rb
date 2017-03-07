class BoardActivityPolicy < ApplicationPolicy

  attr_reader :user, :board_activity, :friend

  def initialize(context, board_activity)
    @user = context.user
    @friend = context.friend
    @board_activity = board_activity
  end

  def destroy?
    is_owner? || (!friend.nil? && friend.activities.any? {|activity| activity.board_activities.include?(board_activity)} && user.admin?)
  end

  private

  def is_owner?
    user && board_activity.activity.user == user
  end

end
