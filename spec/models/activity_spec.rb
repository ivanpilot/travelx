require 'rails_helper'

RSpec.describe Activity, type: :model do

  let(:activity) {
    Activity.create(
      :description => "Trek in the Alps",
      :rating => 5
    )
  }

  it "has a description" do
    expect(activity).to respond_to(:description)
  end

  it "has a rating" do
    expect(activity).to respond_to(:rating)
  end


end
