class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  belongs_to :bet_option
end
