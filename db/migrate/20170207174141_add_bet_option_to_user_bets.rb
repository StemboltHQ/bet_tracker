class AddBetOptionToUserBets < ActiveRecord::Migration[5.0]
  def change
    add_column      :user_bets, :bet_option_id, :integer
    add_foreign_key :user_bets, :bet_options
    add_index       :user_bets, :bet_option_id
  end
end
