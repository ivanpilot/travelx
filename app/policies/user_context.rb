class UserContext

  attr_reader :user, :friend

  def initialize(user, friend)
    @user = user
    @friend = friend
  end

end
