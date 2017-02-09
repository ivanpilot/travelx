require 'rails_helper'

RSpec.describe Activity, type: :model do

  let(:trek) {
    Activity.create(
      :description => "Trek in the Alps",
      :rating => "5",
      :board_id => "1"
    )
  }

  it "has a description" do
    expect(trek.description).to eq("Trek in the Alps")
  end

  it "has a rating" do
    expect(trek.rating).to eq("5")
  end

  it {should have_many (:experiences)}
  it {should have_many (:users)}
  it {should belong_to (:board)}
  it {should have_many (:activity_categories)}
  it {should have_many (:categories)}

  # context "categories" do
  #   let(:sport) { Category.create(:name => "Sport") }
  #
  #   it "has many categories" do
  #     trek.categories << sport
  #     expect(trek.categories).to include(sport)
  #   end
  #
  # end


end
