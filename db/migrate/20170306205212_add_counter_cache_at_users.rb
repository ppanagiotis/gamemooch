class AddCounterCacheAtUsers < ActiveRecord::Migration[5.0]
  def change
  change_table :users do |t|
    t.integer :games_count, default: 0
  end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE users SET games_count = (SELECT count(1) FROM games WHERE games.user_id = users.id)
    SQL
  end
end
