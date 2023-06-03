class PlayersController < ApplicationController

  def create
    Player.create!(player_params)
  end

private

  def player_params
    params.require(:player).permit(:pseudo, :game_id)
  end

end
