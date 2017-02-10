class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :igdb_id
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
