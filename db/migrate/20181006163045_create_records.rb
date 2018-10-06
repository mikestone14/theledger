class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :leaderboard, foreign_key: true, index: true
      t.references :user, foreign_key: true
      t.integer :win_count, null: false, default: 0
      t.integer :loss_count, null: false, default: 0
      t.integer :net_in_cents, null: false, default: 0

      t.timestamps
    end
  end
end
