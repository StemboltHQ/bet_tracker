class Debt < ApplicationRecord
  belongs_to :debtor,   class_name: 'User'
  belongs_to :creditor, class_name: 'User'
  belongs_to :bet, optional: true

  def won_option
    bet.options.winners.first
  end

  def user_option(user)
    user.user_bets.find_by(bet: bet).bet_option
  end
end
