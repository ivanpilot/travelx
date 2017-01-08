require 'rails_helper'

RSpec.describe BoardActivity, type: :model do

  let(:board_activity) {
    BoardActivity.create(
      :activity_id => 1,
      :board_id => 1
    )
  }

  it "has an activity_id" do
    expect(board_activity.activity_id).to eq(1)
  end

  it "has a board_id" do
    expect(board_activity.board_id).to eq(1)
  end

  it {should belong_to(:board)}
  it {should belong_to(:activity)}

end
