class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.integer :status, null: false, index: true

      t.timestamps
    end
  end
end
