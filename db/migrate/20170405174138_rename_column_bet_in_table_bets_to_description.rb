class RenameColumnBetInTableBetsToDescription < ActiveRecord::Migration[5.0]
  def change
    rename_column :bets, :bet, :description
  end
end
