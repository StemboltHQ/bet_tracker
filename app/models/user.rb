class User < ApplicationRecord
  has_many :bets, through: :bet_manager
  has_many :bet_manager
end
