require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:friendship) {
    Friendship.create(
      :user_id => 1,
      :friend_id => 1
    )
  }

  it {should belong_to(:friend)}
  it {should belong_to(:user)}

end
