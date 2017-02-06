class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.references :debtor,   foreign_key: true, index: true
      t.references :creditor, foreign_key: true, index: true
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
