class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @player = Player.new
    @players = Player.where(game_id: params[:id])
    @dices = Dice.where(game_id: params[:id])
    @current_player = @game.current_player.present? ? @game.current_player : @players.first
    @sum = 0
  end

  def new
    @game = Game.create(statut:"en préparation", turn: 1)
    redirect_to game_path(@game)
  end

  def rules
  end

  def update
    @game = Game.find_by(id: params[:id])
    if params[:game][:turn].present? && params[:game][:turn].to_i.positive?
      @game.play(@game)
      @game.turn += 1 if @game.turn < 5
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
