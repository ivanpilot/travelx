class BoardsController < ApplicationController
  before_action :authenticate_user

  def index
    if params[:user_id]
      @boards = User.find_by(id: params[:user_id]).boards
    end
  end

end
