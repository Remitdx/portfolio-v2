class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    @player.pseudo.capitalize!
    @player.pv = 30
    if @player.save
      redirect_to game_path(player_params[:game_id])
      flash[:notice] = "A new player enter the game !"
    else
      redirect_to game_path(player_params[:game_id])
      flash[:alert] = @player.errors[:pseudo].first
    end
  end

private

  def player_params
    params.require(:player).permit(:pseudo, :game_id)
  end

end
