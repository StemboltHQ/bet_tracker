class CreateBetManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :bet_managers do |t|
      t.integer :user_id
      t.integer :bet_id

      t.timestamps
    end
  end
end
