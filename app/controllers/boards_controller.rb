class BoardsController < ApplicationController
  before_action :authenticate_user

  def index
    # if params[:user_id]
    #   @boards = User.find_by(id: params[:user_id]).boards
    # end
    @boards = current_user.boards
  end

  def new
    # @user = User.new
    # @board = Board.new
  end

  def create
    raise params.inspect
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        redirect_to root_path(@user), alert:"Error. User not found."
      else
        @board = @user.boards.find_by(id: params[:id])
        redirect_to user_boards_path(@user), alert:"Board not found." if @board.nil?
      end
    else
      @board = Board.find_by(id:params[:id])
    end
  end

  # private
  #
  # def board_params
  # end

end
