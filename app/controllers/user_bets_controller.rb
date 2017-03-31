class UserBetsController < ApplicationController
  before_action :verify_fields, only: :create

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

  def verify_fields
    bet = Bet.find(params[:bet_id])
    successes = []
    successes << verify_amount
    successes << verify_bet_option
    return unless successes.include?(false)
    redirect_to bet_path(bet)
  end

  def verify_bet_option
    if params[:user_bet][:bet_option_id].nil?
      flash[:danger] = 'Please pick an option before waging on it.'
      false
    else
      true
    end
  end

  def verify_amount
    if !valid_amount?(params[:user_bet][:amount_bet])
      flash[:danger] = 'Please enter a valid amount before placing your bet.'
      false
    else
      true
    end
  end

  def valid_amount?(amount)
    valid_amount_pattern = /^(\d+)(\.?)(\d\d?)$/
    amount.match(valid_amount_pattern).nil? ? false : true
  end
end
