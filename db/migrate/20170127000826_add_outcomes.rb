class AddOutcomes < ActiveRecord::Migration[5.0]
  def change
    create_table :outcomes do |t|
      t.integer :user_id
      t.integer :bet_id
    end
  end
end
