class Game < ApplicationRecord
  searchkick word_start: [:title]
  belongs_to :user
  belongs_to :mooch_user, class_name: 'User', optional: true
  validates :user_id, presence: true
end
