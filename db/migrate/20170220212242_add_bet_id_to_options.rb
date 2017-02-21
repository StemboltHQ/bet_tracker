class AddBetIdToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :bet_options, :bet_id, :integer
    add_foreign_key :bet_options, :bets
    add_index :bet_options, :bet_id
  end
end
