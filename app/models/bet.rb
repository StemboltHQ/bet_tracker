class Bet < ApplicationRecord
  has_many :users, through: :outcome
  has_many :outcome
end
