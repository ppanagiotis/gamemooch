class AddUserIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :user_id, :integer
  end
end
