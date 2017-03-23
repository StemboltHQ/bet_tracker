class DebtsController < ApplicationController
  def index
    @debts = current_user.debts
  end

  def update
    @debt = Debt.find(params[:id])
    @bet = Bet.find(params[:bet_id])
    @debt.update(payment_date: DateTime.current)
    redirect_to @bet
  end
end
