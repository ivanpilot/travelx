class AddRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, :default => "user"
    add_index :users, :email, unique: true
  end
end
