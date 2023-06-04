class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 8
  has_many :dices

  validates :statut, presence: true,
            inclusion: { in: ["en préparation", "en cours", "terminée"] }

  def throw_unlocked_dices(dices)
    dices.each do |dice|
      dice.update!(value: rand(1..6)) if dice.locked == false
    end
  end

  def set_5_new_dices(game_id)
    dices = []
    5.times do
      dice = Dice.new(game_id: game_id, value: rand(1..6), locked: false)
      dice.save
      dices << dice
    end
    return dices
  end

end
