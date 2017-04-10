class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  belongs_to :bet_option

  validates :bet_option_id, presence: true
  validates :user_id, presence: true
  validates :amount_bet, presence: true
  validates :bet_id, presence: true

  accepts_nested_attributes_for :user

  scope :winners, -> { joins(:user, :bet_option).merge(BetOption.winners) }
  scope :losers, -> { joins(:user, :bet_option).merge(BetOption.losers) }
end
