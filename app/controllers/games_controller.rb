class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @player = Player.new
    @players = Player.where(game_id: params[:id])
    @dices = Dice.where(game_id: params[:id])
  end

  def new
    @game = Game.create(statut:"en préparation")
    redirect_to game_path(@game)
  end

  def rules
  end

  def update
    @game = Game.find_by(id: params[:id])
    @game.statut = params[:game][:statut]
    if @game.save
      redirect_to game_path(@game)
    else
      flash[:notice] = "Something went wrong !"
    end
  end

  def play
    @game = Game.find_by(id: params[:game_id])
    @dices = Dice.where(game_id: params[:game_id])
    if @dices == []
      @game.set_5_new_dices(params[:game_id])
    else
      @game.throw_unlocked_dices(@dices)
    end
    redirect_to game_path(@game)
  end

end
