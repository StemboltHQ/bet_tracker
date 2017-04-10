class AddBooleanColumnResolvedToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :resolved, :boolean, default: false
  end
end
