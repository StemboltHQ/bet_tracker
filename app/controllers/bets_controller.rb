class BetsController < ApplicationController
  def index
    @bets = Bet.includes(:user_bets)
  end

  def show
    @bet = Bet.find(params[:id])
    @user_bet = UserBet.new
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
      flash[:danger] = @bet.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def resolve
    @bet = Bet.find(params[:id])
  end

  def calculate_debts; end

  private

  def bet_params
    params.require(:bet).permit(:description, :status, :expires_at, :creator_id)
  end
end
