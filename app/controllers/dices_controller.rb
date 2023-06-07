class DicesController < ApplicationController

  def update
    @dice = Dice.where(id: params[:id])
    params[:dice][:locked] == 'false' ? @dice.update(locked: 'true') : @dice.update(locked: 'false')

    redirect_to game_path(params[:dice][:game_id])
  end

end
