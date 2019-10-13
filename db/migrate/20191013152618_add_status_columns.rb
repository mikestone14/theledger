class AddStatusColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :integer, null: false, default: 0, index: true
    add_column :games, :status, :integer, null: false, default: 0, index: true
  end
end
