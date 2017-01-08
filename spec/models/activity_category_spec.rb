require 'rails_helper'

RSpec.describe ActivityCategory, type: :model do

  let(:categorization) {
    ActivityCategory.create(
      :activity_id => 1,
      :category_id => 1
    )
  }

  it "has an activity_id" do
    expect(categorization.activity_id).to eq(1)
  end

  it "has a category_id" do
    expect(categorization.category_id).to eq(1)
  end

  it {should belong_to(:activity)}
  it {should belong_to(:category)}

end
