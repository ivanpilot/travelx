class BoardsController < ApplicationController
  before_action :authenticate_user, :authenticate_friend#, :reset_boards

  def index
    if params[:user_id] && !current_user.is_friend_with?(User.find_by(id: params[:user_id])) && !current_user.admin?
      flash[:danger] = "You don't have authorization."
      redirect_back(fallback_location: boards_path)
    else
      @boards = policy_scope(Board)
      @board = Board.new
      @activity = Activity.new
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
    end
  end

  def create
    @board = params[:user_id].nil? ? current_user.boards.build(board_params) : User.find_by(id:params[:user_id]).boards.build(board_params)
    authorize @board
    if @board.save
      flash[:success] = "New board successfully created."
    else
      flash[:danger] = "Board not created. Make sure you provide a title and a description and a rating if you add an activity."
      # @activity = Activity.new #must redeclare the variable if using render other @activity in index is nil
      # render :index
    end
    redirect_to to_boards
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
    redirect_to to_boards
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating, :user_id])
  end

  # def reset_boards
  #   @boards = current_user.boards.select {|board| board.id}
  # end

  def to_boards
    if params[:user_id].nil?
      boards_path
    else
      user = User.find_by(id: params[:user_id])
      user_boards_path(user)
    end
  end

end
