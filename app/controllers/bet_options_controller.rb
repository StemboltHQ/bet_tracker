class BetOptionsController < ApplicationController
  before_action :require_login

  def new
    @bet = Bet.find(params[:bet_id])
    @bet_option = BetOption.new
  end

  def create
    @bet = Bet.find(params[:bet_id])
    @bet_option = @bet.options.new(bet_option_params)
    return unless @bet_option.save
    flash[:success] = 'Bet option added'
    redirect_to @bet
  end

  private

  def bet_option_params
    params.require(:bet_option).permit(:option_text)
  end

  def require_login
    return if current_user
    flash[:danger] = 'Please log in first'
    redirect_to new_session_path
  end
end
