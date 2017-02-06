class AddWinnerToBetOptions < ActiveRecord::Migration[5.0]
  def change
    add_column(:bet_options, :winner, :boolean)
  end
end
