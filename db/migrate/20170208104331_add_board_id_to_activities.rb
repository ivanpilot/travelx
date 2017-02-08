class AddBoardIdToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :board_id, :integer
  end
end
