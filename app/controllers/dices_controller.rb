class DicesController < ApplicationController

  def update
    @dice = Dice.find(params[:id])
    @dice.locked == true ? @dice.update(locked: false) : @dice.update(locked: true)
  end

  private

  def dice_params
    params.require(:dice).permit(:game_id, :value, :locked)
  end

end
