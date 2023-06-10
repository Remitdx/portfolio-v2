class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @player = Player.new
    @players = Player.where(game_id: params[:id])
    @dices = Dice.where(game_id: params[:id])
    @game.update(current_player: @players.first.pseudo) if @game.current_player.nil? && @players.present? && @game.current_player != @players.first.pseudo
  end

  def new
    @game = Game.create(statut:"en préparation", turn: 0)
    redirect_to game_path(@game)
  end

  def rules
  end

  def update
    @game = Game.find_by(id: params[:id])
    @dices = Dice.where(game_id: params[:id])

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
      @game.next_player(@game)
      if @game.save
        redirect_to game_path(@game)
      else
        redirect_to root_path
        flash[:notice] = "Something went wrong !"
      end

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
