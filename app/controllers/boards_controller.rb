class BoardsController < ApplicationController
  before_action :authenticate_user

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @boards = @user.boards

      @board = Board.new
      @activity1 = @board.activities.build(user_id: @user.id)
      @activity2 = @board.activities.build(user_id: @user.id)
    else
      @boards = Board.all
    end
  end

  def create
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if @user.nil?
        flash[:danger] = "Please sign in before proceeding."
        redirect_to sign_in_path
      else
        @board = @user.boards.build(board_params)

        if @board.save
          flash[:success] = "New board successfully created."
          redirect_to user_board_path(@user, @board)
        else
          flash[:danger] = "There was an error. The new board couldn't be created."
          redirect_to user_boards_path(@user)
        end
      end
    end
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])

      if @user.nil?
        flash[:danger] = "Please sign in before proceeding."
        redirect_to sign_in_path
      else
        @board = @user.boards.find_by(id: params[:id])

        if @board.nil?
          flash[:danger] = "Board not found."
          redirect_to user_boards_path(@user)
        end
      end

    else
      @board = Board.find_by(id:params[:id])
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating, :user_id])
  end

end
