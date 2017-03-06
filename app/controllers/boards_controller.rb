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
      @activities = @board.activities.build#(user_id: current_user.id)
      # @user = User.find_by(id: params[:user_id]) if params[:user_id]
      # @activityy = current_user.activities.build(user_id: current_user.id)
      # @activities = @b
    end

    # if params[:user_id] && User.exists?(params[:user_id])
    #   @boards = User.find_by(id:params[:user_id]).boards
    #   @board = Board.new # TO BE DELETED #############
    # else
    #   @boards = current_user.boards
    #   @board = Board.new
    # end
  end

  def create
    authorize Board
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = "New board successfully created."
      redirect_to boards_path
    else
      flash.now[:danger] = "Board not created. Make sure you provide a title and a description and a rating if you add an activity."
      render :index
    end

    # @board = current_user.boards.build(board_params)
# raise params.inspect
    # if @board.save
#       flash[:success] = "New board successfully created."
#       redirect_to boards_path
#     else
#       flash.now[:danger] = "Board not created. Make sure you provide a title and a description and a rating if you add an activity."
# # @activity3 = @board.activities.build(user_id: current_user.id)
# # @activity4 = @board.activities.build(user_id: current_user.id)
#       render :index
    # end
  end

  def edit
    @board = current_user.boards.find_by(id: params[:id])
    if @board.nil?
      flash[:danger] = "Board not found."
      redirect_to boards_path
    end

    # if params[:user_id] && correct_user?(params[:user_id])
    #   @board = current_user.boards.find_by(id: params[:id])
    #
    #   if @board.nil?
    #     flash[:danger] = "Board not found."
    #     redirect_to user_boards_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def update
    @board = current_user.boards.find_by(id: params[:id])
    redirect_to boards_path unless @board
    if @board.update(board_params)
      flash[:success] = "Board updated."
      redirect_to board_path(@board)
    else
      flash.now[:danger] = "Please try again."
      render :edit
    end

    # if params[:user_id] && correct_user?(params[:user_id])
    #   if @board = current_user.boards.find_by(id: params[:id])
    #     @board.update(board_params)
    #     flash[:success] = "Board updated."
    #     redirect_to user_board_path(current_user, @board)
    #   else
    #     flash[:danger] = "Board not found."
    #     redirect_to user_boards_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def show
    # @board = current_user.boards.find_by(id: params[:id])
    @board = Board.find_by(id: params[:id])

    if @board.nil?
      flash[:danger] = "Board not found."
      redirect_to boards_path
    end

    # if params[:user_id] && correct_user?(params[:user_id])
    #   @board = current_user.boards.find_by(id: params[:id])
    #
    #   if @board.nil?
    #     flash[:danger] = "Board not found."
    #     redirect_to user_boards_path(current_user)
    #   end
    # else
    #   redirect_to user_boards_path(current_user)
    # end
  end

  def destroy
    @board = current_user.boards.find_by(id: params[:id])
    redirect_to boards_path unless @board
    if !@board.nil?
      @board.destroy
      flash[:success] = "Board deleted."
      @board = nil
      redirect_to boards_path
    else
      flash[:danger] = "Board couldn't be deleted."
      redirect_to board_path(@board)
    end

    # if params[:user_id] && correct_user?(params[:user_id])
    #   @board = current_user.boards.find_by(id: params[:id])
    #
    #   if !@board.nil?
    #     @board.destroy
    #     flash[:success] = "Board deleted."
    #     @board = nil
    #   else
    #     flash[:danger] = "Board couldn't be found or updated."
    #   end
    # end
    # redirect_to user_boards_path(current_user)
  end

  private

  def board_params
    params.require(:board).permit(:title, activities_attributes:[:description, :rating, :user_id])
  end

  def reset_boards
    @boards = current_user.boards.select {|board| board.id}
  end


end
