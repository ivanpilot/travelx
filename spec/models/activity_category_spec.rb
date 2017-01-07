require 'rails_helper'

RSpec.describe ActivityCategory, type: :model do

  let(:activity_category) {
    ActivityCategory.create(
      :activity_id => 1,
      :category_id => 1
    )
  }

  it "has an activity_id" do
    expect(activity_category).to respond_to(:activity_id)
  end

  it "has a category_id" do
    expect(activity_category).to respond_to(:category_id)
  end


end
