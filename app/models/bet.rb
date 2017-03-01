class Bet < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets
  has_many :options, through: :user_bets, source: :bet_option

  def resolve(winning_option:)
    winning_option.update!(winner: true)
    debt_relationships = user_bets.winners.to_a.product(user_bets.losers.to_a)
    debt_relationships.map do |(won_bet, lost_bet)|
      resolve_debt(lost_bet, won_bet) unless lost_bet.user == won_bet.user
    end.compact
  end

  def winner_total
    @winner_total ||= user_bets.winners.map(&:amount_bet).sum
  end

  def amount_owed(lost_bet, won_bet)
    won_option = options.find_by(winner: true).option_total
    lost_bet.amount_bet * (won_bet.amount_bet / won_option).round(2)
  end

  def bet_total
    user_bets.pluck(:amount_bet).sum
  end

  private

  def resolve_debt(lost_bet, won_bet)
    existing_debt = Debt.find_by(debtor: lost_bet.user, creditor: won_bet.user)
    if existing_debt
      update_debt(existing_debt, lost_bet, won_bet)
    else
      create_debt(lost_bet, won_bet)
    end
  end

  def create_debt(lost_bet, won_bet)
    Debt.create(
      debtor: lost_bet.user,
      creditor: won_bet.user,
      amount:  amount_owed(lost_bet, won_bet)
    )
  end

  def update_debt(debt, lost_bet, won_bet)
    updated_amount = debt.amount + amount_owed(lost_bet, won_bet)
    debt.update!(amount: updated_amount)
  end
end
