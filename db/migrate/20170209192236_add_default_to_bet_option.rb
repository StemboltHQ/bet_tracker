class AddDefaultToBetOption < ActiveRecord::Migration[5.0]
  def change
    change_column :bet_options, :winner, :boolean, default: false
  end
end
