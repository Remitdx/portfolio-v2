class Player < ApplicationRecord
  belongs_to :game

  validates :pseudo, presence: true #, uniqueness: scope: same game
end
