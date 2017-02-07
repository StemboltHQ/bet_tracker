class AddForeignKeysToUserBets < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :user_bets, :users
    add_index       :user_bets, :user_id

    add_foreign_key :user_bets, :bets
    add_index       :user_bets, :bet_id
  end
end
