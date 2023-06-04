class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @player = Player.new
    @players = Player.where(game_id: params[:id])
  end

  def new
    @game = Game.create(statut:"en préparation")
    redirect_to game_path(@game)
  end

  def rules
  end

  def update
    @game = @game = Game.find_by(id: params[:id])
    @game.statut = params[:game][:statut]
    if @game.save
      redirect_to game_path(@game)
    else
      flash[:notice] = "Something went wrong !"
    end
  end

end
