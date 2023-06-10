class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 8
  has_many :dices, dependent: :destroy

  validates :statut, presence: true,
            inclusion: { in: ["en préparation", "en cours", "terminée"] }


  def play(game)
    dices = Dice.where(game_id: game.id)
    if dices == []
      game.set_new_dices(5, game.id)
    else
      game.throw_unlocked_dices(dices)
    end
  end

  def throw_unlocked_dices(dices)
    dices.each do |dice|
      dice.update!(value: rand(1..6)) if dice.locked == false
    end
  end

  def set_new_dices(n, game_id)
    dices = []
    n.times do
      dice = Dice.new(game_id: game_id, value: rand(1..6), locked: false)
      dice.save
      dices << dice
    end
    return dices
  end

end
