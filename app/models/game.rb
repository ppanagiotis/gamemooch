class Game < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  def self.search(search)
    where("title LIKE ?", "%#{search}%") 
  end
end
