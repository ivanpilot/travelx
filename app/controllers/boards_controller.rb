class BoardsController < ApplicationController
  before_action :authenticate_user


  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @board = Board.new
      # @boards = User.find_by(id: params[:user_id]).boards
      @activity1 = @board.activities.build
      @activity2 = @board.activities.build
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
        flash[:success] = "New board successfully created."
        redirect_to user_board_path(@user, @board)
      else
        flash[:alert] = "There was an error. The new board couldn't be created."
        redirect_to root_path(@user)
      end
    end
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:alert] = "User not found."
        redirect_to root_path(@user)
      else
        @board = @user.boards.find_by(id: params[:id])
        if @board.nil?
          flash[:alert] = "Board not found."
          redirect_to user_boards_path(@user)
        end
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
