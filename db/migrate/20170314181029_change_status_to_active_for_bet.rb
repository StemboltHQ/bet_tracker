class ChangeStatusToActiveForBet < ActiveRecord::Migration[5.0]
  def change
    rename_column :bets, :status, :active
    change_column :bets, :active, :boolean, default: true
  end
end
