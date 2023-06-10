class DicesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:update]

  def update
    @dice = Dice.find(params[:id])
    @dice.locked == true ? @dice.update(locked: false) : @dice.update(locked: true)
    respond_to do |format|
      format.html { redirect_to restaurant_path(@dice.game_id) }
      format.json { render :json => @dice }
    end
  end

  private

  def dice_params
    params.require(:dice).permit(:game_id, :value, :locked)
  end

end
