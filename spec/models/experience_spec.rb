require 'rails_helper'

RSpec.describe Experience, type: :model do

  let(:experience) {
    Experience.create(
      :user_id => 1,
      :activity_id => 1
    )
  }

  it "has an activity_id" do
    expect(experience.activity_id).to eq(1)
  end

  it "has a user_id" do
    expect(experience.user_id).to eq(1)
  end

  it {should belong_to(:user)}
  it {should belong_to(:activity)}



end
