class BetOptionsController < ApplicationController
  before_action :require_login

  def new
    @bet = Bet.find(params[:bet_id])
    @bet_option = BetOption.new
  end

  def create; end

  private

  def require_login
    return if current_user
    flash[:danger] = 'Please log in first'
    redirect_to new_session_path
  end
end
