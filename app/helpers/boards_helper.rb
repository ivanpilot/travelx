module BoardsHelper

  def show_valid_boards(current_user)
    current_user.boards.select {|board| board.id}
  end

end
