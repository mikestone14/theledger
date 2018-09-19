class AddNameToSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :seasons, :name, :string
  end
end
