class CreateLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboards do |t|
      t.references :season, foreign_key: true, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
