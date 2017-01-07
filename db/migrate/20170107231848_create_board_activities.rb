class CreateBoardActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :board_activities do |t|
      t.integer :board_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
