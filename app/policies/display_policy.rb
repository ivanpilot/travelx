class DisplayPolicy < ApplicationPolicy

  attr_reader :user, :menu

  def initialize(user, menu)
    @user = user
    @menu = menu
  end



  class Scope < Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      end
    end
  end

end
