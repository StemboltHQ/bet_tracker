class AddCreatorIdToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :creator_id, :integer
  end
end
