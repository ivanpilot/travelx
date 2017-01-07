require 'rails_helper'

RSpec.describe Board, type: :model do

  let(:board) {
    Board.create(
      :title => "Winter 2016",
      :user_id => 1
    )
  }

  it "has a title" do
    expect(board).to respond_to(:title)
  end

  it "has a user_id" do
    expect(board).to respond_to(:user_id)
  end


end
