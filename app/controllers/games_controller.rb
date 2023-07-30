class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @dice = Dice.new
    @player = Player.new
    @players = Player.where(game_id: params[:id])
    @dices = Dice.where(game_id: params[:id])
    @game.update(current_player: @players.first.pseudo) if @game.current_player.nil? && @players.present? && @game.current_player != @players.first.pseudo
    @game.update(sum: @game.calculate_score(@dices)) if @dices != []
    @game.update(damage: @game.damage_amount) unless @game.sum.nil?
  end

  def new
    @game = Game.create(statut:"en préparation", substatut:"roll_five_dices", turn: 0)
    redirect_to game_path(@game)
  end

  def rules
  end

  def update
    @game = Game.find_by(id: params[:id])
    @dices = Dice.where(game_id: params[:id])
    @player = Player.find_by(game_id: @game.id, pseudo: @game.current_player)

    if params[:game][:turn].present? && params[:game][:turn].to_i.between?(0,4) && @game.still_unlocked_dices?(@dices)
      @game.throw_dices(@game)
      @game.turn += 1
      if @game.save
        redirect_to game_path(@game)
      else
        redirect_to root_path
        flash[:notice] = "Something went wrong !"
      end

    elsif params[:game][:turn].present?
      @game.action(@game)
      redirect_to game_path(@game)

    elsif params[:game][:substatut].present?
      case params[:game][:substatut]
        when "heal_yourself"
          @amount = Dice.last.value
          @game.heal_yourself(@player, @amount)
          Dice.last.destroy
        when "damage_yourself"
          @game.damage_yourself(@player, @game.damage)
        when "damage_others"
          @game.damage_others(@player, @game.damage)
        end
      @game.next_player(@game)
      redirect_to game_path(@game)
    else
      @game.statut = params[:game][:statut]
      if @game.save
        redirect_to game_path(@game)
      else
        flash[:notice] = "Something went wrong !"
      end
    end
  end

end
