class BetsController < ApplicationController
  include Utilities::Paginator
  helper Utilities::Paginator

  def index
    current_page = params[:page].nil? ? 1 : params[:page].to_i
    @bets = items_to_display(model: Bet,
                             items_per_page: 25,
                             current_page: current_page)
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

  private

  def bet_params
    params.require(:bet).permit(:description, :status, :expires_at, :creator_id)
  end
end
