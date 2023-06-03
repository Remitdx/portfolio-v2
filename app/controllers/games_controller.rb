class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find_by(id: params[:id])
    @player = Player.new
    @players = Player.where(game_id: params[:id])
  end

  def new
    @game = Game.create
    redirect_to game_path(@game)
  end

end
