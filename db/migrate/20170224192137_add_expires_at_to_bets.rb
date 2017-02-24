class AddExpiresAtToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :expires_at, :datetime
  end
end
