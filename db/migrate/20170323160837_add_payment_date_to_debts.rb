class AddPaymentDateToDebts < ActiveRecord::Migration[5.0]
  def change
    add_column :debts, :payment_date, :datetime
  end
end
