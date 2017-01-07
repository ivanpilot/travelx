require 'rails_helper'

RSpec.describe BoardActivity, type: :model do

  let(:board_activity) {
    BoardActivity.create(
      :activity_id => 1,
      :board_id => 1
    )
  }

  it "has an activity_id" do
    expect(board_activity).to respond_to(:activity_id)
  end

  it "has a board_id" do
    expect(board_activity).to respond_to(:board_id)
  end


end
