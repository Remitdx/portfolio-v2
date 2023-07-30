class Dice < ApplicationRecord
  belongs_to :game

  def convert_keep_to_locked_dice
    self.update!(state: 'locked') if self.state == 'keep'
  end
end
