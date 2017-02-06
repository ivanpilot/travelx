class BoardsController < ApplicationController
  before_action :authenticate_user


  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @board = Board.new
      # @boards = User.find_by(id: params[:user_id]).boards
    else
      @boards = Board.all
    end
  end

  # def new
  #   # @user = User.new
  #   if params[:user_id] && !User.exists?(params[:user_id])
  #     redirect_to root_path(@user), alert:"User not found."
  #   else
  #     @board = Board.new(user_id: params[:user_id])
  #   end
  #   raise params.inspect
  # end

  def create
    # raise params.inspect
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      redirect_to root_path(@user), alert:"User not found." if @user.nil?
      @board = @user.boards.build(board_params)

      if @board.save
        redirect_to user_board_path(@user, @board), success:"New board successfully created."
      else
        redirect_to root_path(@user), alert:"There was an error. The new board couldn't be created."
      end
    end
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        redirect_to root_path(@user), alert:"User not found."
      else
        @board = @user.boards.find_by(id: params[:id])
        redirect_to user_boards_path(@user), alert:"Board not found." if @board.nil?
      end

    else
      @board = Board.find_by(id:params[:id])
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating])
  end

end
