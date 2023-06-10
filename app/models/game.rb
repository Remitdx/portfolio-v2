class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 8
  has_many :dices, dependent: :destroy

  validates :statut, presence: true,
            inclusion: { in: ["en préparation", "en cours", "terminée"] }

  def next_player(game)
    players = Player.where(game_id: game.id)
    a = players.map { |player| player[:pseudo] }
    game.current_player = a[((a.index(game.current_player) + 1) % a.length)]
    game.turn = 0
    game.save
    dices = Dice.where(game_id: game.id)
    dices.each do |dice|
      dice.update(locked: false)
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

  def still_unlocked_dices?(dices)
    return true if dices == []
    copy_dices = dices.map { |dice| dice[:locked] }
    return copy_dices.include?(false) ? true : false
  end

  def throw_dices(game)
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
end
