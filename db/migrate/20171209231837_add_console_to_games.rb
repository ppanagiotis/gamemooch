class AddConsoleToGames < ActiveRecord::Migration[5.0]
  def change
    create_table :consoles do |t|
      t.string :name
    end
    add_column :games, :console_id, :integer
  end
end
