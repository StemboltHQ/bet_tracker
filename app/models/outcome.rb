class Outcome < ApplicationRecord
  belongs_to :bet
  belongs_to :user
end
