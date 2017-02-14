class BoardsController < ApplicationController
  before_action :authenticate_user, :reset_boards

  def index
    if params[:user_id] && correct_user?(params[:user_id])
      @boards = current_user.boards
      @board = Board.new
      @activity1 = @board.activities.build(user_id: current_user.id)
      @activity2 = @board.activities.build(user_id: current_user.id)
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def create
    if params[:user_id] && correct_user?(params[:user_id])
      @board = current_user.boards.build(board_params)

      if @board.save
        flash[:success] = "New board successfully created."
        redirect_to user_board_path(current_user, @board)
      else
        render :index
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def show
    if params[:user_id] && correct_user?(params[:user_id])
      @board = current_user.boards.find_by(id: params[:id])

      if @board.nil?
        flash[:danger] = "Board not found."
        redirect_to user_boards_path(current_user)
      end
    else
      redirect_to user_boards_path(current_user)
    end
  end

  def destroy
    if params[:user_id] && correct_user?(params[:user_id])
      @board = current_user.boards.find_by(id: params[:id])

      if !@board.nil?
        @board.delete
        flash[:success] = "Board deleted."
        @board = nil
      else
        flash[:danger] = "Board couldn't be found or updated."
      end
    end
    redirect_to user_boards_path(current_user)
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating, :user_id])
  end

  def reset_boards
    @boards = current_user.boards.select {|board| board.id}
  end

end
