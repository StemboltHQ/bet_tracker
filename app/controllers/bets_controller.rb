class BetsController < ApplicationController
  def index
    @bets = Bet.all
  end

  def show
    @bet = Bet.find(params[:id])
  end

  def new
    @bet = Bet.new
  end

  def create
    @bet = Bet.new(bet_params)
    if @bet.save
      flash[:success] = 'Bet has been created'
      redirect_to @bet
    else
      flash[:danger] = 'Could not create bet'
      render 'new'
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:bet, :status, :expires_at, :creator_id)
  end
end
