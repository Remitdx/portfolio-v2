class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    @player.pseudo.capitalize!
    @player.pv = 30
    if @player.save
      flash[:notice] = "A new player enter the game !"
    else
      flash[:alert] = @player.errors[:pseudo].first
    end
    redirect_to game_path(player_params[:game_id])
  end

  private

  def player_params
    params.require(:player).permit(:pseudo, :game_id)
  end
end
