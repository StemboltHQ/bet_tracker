class Bet < ApplicationRecord
  has_many :users, through: :bet_manager
  has_many :bet_manager
end
