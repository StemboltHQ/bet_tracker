class ChangeAmountBetToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :user_bets, :amount_bet, :decimal, precision: 10, scale: 2
  end
end
