class RemoveBoardIdFromActivity < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :board_id, :integer
  end
end
