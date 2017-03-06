class BoardsController < ApplicationController
  before_action :authenticate_user, :reset_boards, :authenticate_friend

  def index
    if params[:user_id] && !current_user.is_friend_with?(User.find_by(id: params[:user_id])) && !current_user.admin?
      flash[:danger] = "You don't have authorization."
      redirect_back(fallback_location: boards_path)
    else
      @boards = policy_scope(Board)
      @board = Board.new
      @activity = current_user.activities.build### MUST BE MODIFIED IF ADMIN CREATE!!!!
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
    end
  end

  def create
    authorize Board
    @board = current_user.boards.build(board_params)### MUST BE MODIFIED IF ADMIN CREATE!!!!
    if @board.save
      flash[:success] = "New board successfully created."
      redirect_to boards_path
    else
      flash.now[:danger] = "Board not created. Make sure you provide a title and a description and a rating if you add an activity."
      render :index
    end
  end

  def show
    if params[:user_id] && !current_user.is_friend_with?(User.find_by(id: params[:user_id])) && !current_user.admin?
      flash[:danger] = "You don't have authorization."
      redirect_back(fallback_location: boards_path)
    else
      @board = Board.find_by(id: params[:id])
      if @board
        authorize @board
        @user = User.find_by(id: params[:user_id]) if params[:user_id]
      else
        flash[:danger] = "Board not found."
        redirect_to boards_path
      end
    end
  end

  def edit
    @board = Board.find_by(id: params[:id])
    if @board
      authorize @board
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
      store_previous_url
    else
      flash[:danger] = "Board not found."
      redirect_to activities_path
    end
  end

  def update
    @board = Board.find_by(id: params[:id])
    redirect_to boards_path unless @board
    authorize @board
    if @board.update(board_params)
      flash[:success] = "Board updated."
      go_to_previous_url
    else
      flash.now[:danger] = "Please try again."
      render :edit
    end
  end

  def destroy
    @board = Board.find_by(id: params[:id])
    if @board
      authorize @board
      @board.destroy
      flash[:success] = "Board deleted."
      @board = nil
    else
      flash[:danger] = "Board couldn't be found or deleted."
    end
    redirect_to_boards
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating, :user_id])
  end

  def reset_boards
    @boards = current_user.boards.select {|board| board.id}
  end

  def redirect_to_boards
    if params[:user_id].nil?
      redirect_to boards_path
    else
      user = User.find_by(id: params[:user_id])
      redirect_to user_boards_path(user)
    end
  end

end
