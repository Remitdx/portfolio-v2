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
    @dice.state == 'keep' ? @dice.update(state: 'free') : @dice.update(state: 'keep')
    respond_to do |format|
      format.html {  }
      format.json { render :json => @dice }
    end
  end

end
