class Game < ApplicationRecord
  has_many :players, dependent: :destroy # limiter nb joueur à 8
  has_many :dices, dependent: :destroy

  validates :statut, presence: true,
            inclusion: { in: ["en préparation", "en cours", "terminée"] }

  def action(game)
    if game.sum == 11 || game.sum == 24
      game.update(substatut: "heal_yourself")
    elsif game.sum < 11 || game.sum > 24
      game.update(substatut: "damage_others")
    else
      game.update(substatut: "damage_yourself")
    end
  end

  def calculate_score(dices)
    sum = 0
    dices.each do |dice|
      sum += dice.value
    end
    return sum
  end

  def damage_amount
    return [(self.sum - 24).abs(), (self.sum - 11).abs].min
  end

  def damage_others(player, damage)
    # RAF
  end

  def damage_yourself(player, damage)
    player.update(pv: player.pv - damage)
  end

  def heal_yourself(player, amount)
    player.update(pv: player.pv + amount)
  end

  def next_player(game)
    players = Player.where(game_id: game.id)
    a = players.map { |player| player[:pseudo] }
    game.current_player = a[((a.index(game.current_player) + 1) % a.length)]
    game.update!(turn: 0, substatut: "roll_five_dices", sum: nil)
    dices = Dice.where(game_id: game.id)
    dices.destroy_all
  end

  def set_new_dices(n, game_id)
    dices = []
    n.times do
      dice = Dice.new(game_id: game_id, value: rand(1..6), state: 'free')
      dice.save
      dices << dice
    end
    return dices
  end

  def still_unlocked_dices?(dices)
    return true if dices == []
    copy_dices = dices.map { |dice| dice[:state] }
    return copy_dices.include?('free') ? true : false
  end

  def throw_dices(game)
    dices = Dice.where(game_id: game.id)
    dices.each { |dice| dice.convert_keep_to_locked_dice }
    if dices == []
      game.set_new_dices(5, game.id)
    else
      game.throw_unlocked_dices(dices)
    end
  end

  def throw_unlocked_dices(dices)
    dices.each do |dice|
      dice.update!(value: rand(1..6)) if dice.state === 'free'
    end
  end
end
