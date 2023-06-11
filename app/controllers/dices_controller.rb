class DicesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def create
    @dice = Dice.create(game_id: params[:dice][:game_id], value: rand(1..6))
    respond_to do |format|
      format.html { }
      format.json { render :json => @dice }
    end
  end

  def update
    @dice = Dice.find(params[:id])
    @dice.locked == true ? @dice.update(locked: false) : @dice.update(locked: true)
    respond_to do |format|
      format.html {  }
      format.json { render :json => @dice }
    end
  end

end
