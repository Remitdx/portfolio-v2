class Dice < ApplicationRecord
  belongs_to :game

  def is_locked?
    return self.locked
  end
end
