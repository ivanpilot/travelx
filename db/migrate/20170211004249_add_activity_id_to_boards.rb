class AddActivityIdToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :activity_id, :integer
  end
end
