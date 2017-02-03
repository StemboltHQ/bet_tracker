class RenameOutcomesUserBets < ActiveRecord::Migration[5.0]
  def change
    rename_table :outcomes, :user_bets
    add_column :user_bets, :amount_bet, :integer
  end
end
