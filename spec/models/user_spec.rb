require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.create(
      :username => "user",
      :email => "user@test.com",
      :role => "user"
    )
  }

  let(:activity) {
    Activity.create(
      :description => "Eating at amazing pizzeria",
      :rating => 4
    )
  }

  it "has a username" do
    expect(user).to respond_to(:username)
  end

  it "it has an email" do
    expect(user).to respond_to(:email)
  end

  it "it has a role" do
    expect(user).to respond_to(:role)
  end

  it "is not valid without an email" do
    expect(User.new(username: "user", password: "password")).not_to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(username: "user", email: "user@test.com")).not_to be_valid
  end

  it "can have activities" do
    new_activity = Activity.create(:description => "Eating at amazing pizzeria", :rating => 4)
    expect(user.activities).to include(new_activity)
  end





end
