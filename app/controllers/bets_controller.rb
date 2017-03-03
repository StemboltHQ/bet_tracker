class BetsController < ApplicationController
  def show
    @bet = Bet.find(params[:id])
  end

  def new
    @bet = Bet.new
  end
end
