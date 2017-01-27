class AddBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.text    :bet
      t.integer :status

      t.timestamps
    end
  end
end
