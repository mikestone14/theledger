class AddScoreToRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :score, :decimal, scale: 2, precision: 12, null: false, default: 0
  end
end
