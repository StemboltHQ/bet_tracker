class Bet < ApplicationRecord
  include DebtFilter
  has_many :users, through: :user_bets
  has_many :user_bets
  has_many :options, class_name: 'BetOption'
  has_many :debts
  belongs_to :creator, class_name: 'User'

  validates :expires_at, presence: true
  validates :creator_id, presence: true
  validates_with ExpiryDateValidator

  def resolve(winning_option:)
    winning_option.update!(winner: true)
    debt_relationships = user_bets.winners.to_a.product(user_bets.losers.to_a)
    save_debts(debt_relationships.map do |(won_bet, lost_bet)|
      Debt.new(
        creditor: won_bet.user,
        debtor: lost_bet.user,
        amount:  amount_owed(lost_bet, won_bet),
        bet: self
      )
    end)
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
end
