class UserBetsController < ApplicationController
  def create
    @bet = Bet.find(params[:bet_id])
    @user_bet = @bet.user_bets.new(user_bet_params)
    if @user_bet.save
      flash[:success] = 'Your bet has been successfully placed!'
    else
      flash[:danger] = 'Couldn\'t place your bet.'
    end
    redirect_to bet_path(@bet)
  end

  private

  def user_bet_params
    params.require(:user_bet)
          .permit(:user_id, :bet_id, :amount_bet, :bet_option_id)
  end
end
