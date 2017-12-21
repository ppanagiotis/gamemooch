class Game < ApplicationRecord
  searchkick word_start: [:title]
  belongs_to :user, counter_cache: :games_count
  belongs_to :mooch_user, class_name: 'User', optional: true
  validates :user_id, presence: true
  belongs_to :console
  enum console: Rails.configuration.platforms
end
