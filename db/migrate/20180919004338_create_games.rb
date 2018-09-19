class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :season, index: true, foreign_key: true, null: false
      t.references :winner, index: true, null: false
      t.references :loser, index: true, null: false
      t.integer :price_in_cents, null: false

      t.timestamps
    end

    add_foreign_key :games, :users, column: :winner_id
    add_foreign_key :games, :users, column: :loser_id
  end
end
