class User < ApplicationRecord
  has_many :bets, through: :user_bets
  has_many :user_bets
  has_many :debts,   class_name: 'Debt', foreign_key: :debtor_id
  has_many :credits, class_name: 'Debt', foreign_key: :creditor_id
  has_many :created_bets, class_name: 'Bet'

  has_secure_password
end
