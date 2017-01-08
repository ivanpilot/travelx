require 'rails_helper'

RSpec.describe Board, type: :model do

  let(:winter) {
    Board.create(
      :title => "Winter 2016",
      :user_id => 1
    )
  }

  it "has a title" do
    expect(winter.title).to eq("Winter 2016")
  end

  it "has a user_id" do
    expect(winter.user_id).to eq(1)
  end

  it {should belong_to(:user)}
  it {should have_many(:board_activities)}
  it {should have_many(:activities)}


end
