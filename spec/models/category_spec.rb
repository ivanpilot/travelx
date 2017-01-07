require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:category) {
    Category.create(
      :name => "Sport"
    )
  }

  it "has a name" do
    expect(category).to respond_to(:name)
  end



end
