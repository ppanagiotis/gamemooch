class Game < ApplicationRecord
  belongs_to :user
  belongs_to :mooch_user, class_name: 'User', optional: true
  validates :user_id, presence: true
  def self.search(search)
    where("title LIKE ?", "%#{search}%") 
  end
end
