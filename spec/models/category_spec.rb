require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:sport) {
    Category.create(
      :name => "Sport"
    )
  }

  it "has a name" do
    expect(sport.name).to eq("Sport")
  end

  it {should have_many(:activity_categories)}
  it {should have_many(:categories)}

end
