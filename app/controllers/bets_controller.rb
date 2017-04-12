class BetsController < ApplicationController
  before_action :check_bet_creator, only: :resolve
  before_action :check_if_resolved, only: :resolve

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

  def check_bet_creator
    @bet = Bet.find(params[:id])
    return if current_user == @bet.creator
    flash[:danger] = 'You cannot resolve this bet because you did\'t create it'
    redirect_to @bet
  end

  def check_if_resolved
    @bet = Bet.find(params[:id])
    return unless @bet.resolved
    flash[:danger] = 'This bet has been already resolved'
    redirect_to @bet
  end
end
