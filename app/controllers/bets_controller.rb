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

  def calculate_debts
    bet = Bet.find(params[:id])
    if params[:bet_option_id].nil?
      resolve_option_not_selected(bet)
    else
      winning_option = BetOption.find(params[:bet_option_id])
      resolve_option_selected(bet, winning_option)
    end
  end

  def resolve_option_selected(bet, winning_option)
    bet.resolve(winning_option: winning_option)
    flash[:success] = 'Bet has been resolved!'
    bet.update(resolved: true)
    redirect_to bet
  end

  def resolve_option_not_selected(bet)
    flash[:danger] = 'Please select an option first'
    redirect_to resolve_bet_path(bet)
  end

  private

  def bet_params
    params.require(:bet).permit(:description, :status, :expires_at, :creator_id)
  end
end
