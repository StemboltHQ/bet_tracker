class AddPayedColumnToDebt < ActiveRecord::Migration[5.0]
  def change
    add_column :debts, :payed, :boolean, default: false
  end
end
