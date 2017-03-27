class AddHasManyBelongsToRelationshipBetweenBetAndDebt <
  ActiveRecord::Migration[5.0]
  def change
    add_reference :debts, :bet, foreign_key: true
  end
end
