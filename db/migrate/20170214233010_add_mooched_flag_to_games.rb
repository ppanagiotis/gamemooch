class AddMoochedFlagToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :mooched, :boolean, default: false
  end
end
