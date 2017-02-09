require 'rails_helper'

RSpec.describe User, type: :model do

  let(:james) {
    User.create(
      :username => "james",
      :email => "user@test.com",
      :role => "user",
      :password => "password"
    )
  }

  it "has a username" do
    expect(james.username).to eq("james")
  end

  it "has an email" do
    expect(james.email).to eq("user@test.com")
  end

  it "has a role" do
    expect(james.role).to eq("user")
  end

  it "has a password" do
    expect(james).to respond_to(:password)
  end

  # it {should have_many (:experiences)}
  it {should have_many (:activities)}
  it {should have_many (:boards)}
  it {should have_many (:friendships)}
  it {should have_many (:friends)}

  # it "is not valid without an email" do
  #   expect(User.new(username: "user", password: "password")).not_to be_valid
  # end

  # it "is not valid without a password" do
  #   expect(User.new(username: "user", email: "user@test.com")).not_to be_valid
  # end

  # context "activities and experiences" do
  #   let(:activity) {
  #     Activity.create(
  #       :description => "Eating at amazing pizzeria",
  #       :rating => 4
  #     )
  #   }
  #
  #   it "has many activities" do
  #     james.activities << activity
  #     expect(james.activities).to include(activity)
  #   end
  #
  # end
  #
  # context "boards" do
  #   let(:winter) {
  #     Board.create(
  #       :title => "Winter 2016",
  #       :user_id => james.id
  #     )
  #   }
  #
  #   it "has many activities" do
  #     expect(james.boards).to include(winter)
  #   end
  #
  # end





  # it "can have activities" do
  #   new_activity = Activity.create(:description => "Eating at amazing pizzeria", :rating => 4)
  #   expect(user.activities).to include(new_activity)
  # end
end
