class BetsController < ApplicationController
  def index
    @bets = Bet.includes(:user_bets)
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
      flash[:danger] = @bet.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:bet, :status, :creator_id)
          .merge(expires_at: convert_date_to_server_time)
  end

  def convert_date_to_server_time
    user_date_string = params[:bet][:expires_at]
    user_date_utc = DateTime.now.strftime('%z')
    (user_date_string + ' UTC' + user_date_utc).to_datetime.utc
  end
end
