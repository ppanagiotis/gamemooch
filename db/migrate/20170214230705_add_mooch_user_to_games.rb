class AddMoochUserToGames < ActiveRecord::Migration[5.0]
  def change
    add_reference(:games, :mooch_user, foreign_key: {to_table: :users})
  end
end
