class DropExperiencesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :experiences
  end
end
