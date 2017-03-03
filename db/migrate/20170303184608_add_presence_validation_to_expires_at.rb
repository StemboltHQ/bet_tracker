class AddPresenceValidationToExpiresAt < ActiveRecord::Migration[5.0]
  def change
    change_column_null :bets, :expires_at, false
  end
end
