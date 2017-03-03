class AddPresenceValidationToCreatorId < ActiveRecord::Migration[5.0]
  def change
    change_column_null :bets, :creator_id, false
  end
end
