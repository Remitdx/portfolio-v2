class Dice < ApplicationRecord
  belongs_to :game

  def convert_keep_to_locked_dice
    update!(state: 'locked') if state == 'keep'
  end
end
