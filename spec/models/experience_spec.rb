require 'rails_helper'

RSpec.describe Experience, type: :model do

  let(:experience) {
    Experience.create(
      :user_id => 1,
      :activity_id => 1
    )
  }

  it "has an activity_id" do
    expect(experience).to respond_to(:activity_id)
  end

  it "has a user_id" do
    expect(experience).to respond_to(:user_id)
  end



end
