class DisplayPolicy# < Struct.new(:user, :display)

  attr_reader :user, :activity, :friend

  def initialize(context, activity)
    @user = context.user
    @friend = context.friend
    @activity = activity
  end

  def show?
    if !friend.nil? && !user.admin?
      false
    else
      true
    end
  end

end
