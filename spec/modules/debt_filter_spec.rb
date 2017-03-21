require 'rails_helper'

RSpec.describe DebtFilter, type: :module do
  let(:debt_filter) { Class.new { extend DebtFilter } }
  let(:bob) do
    User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
  end
  let(:peter) do
    User.create(username: 'Peter', email: 'peter@mail.com', password: 'pete1')
  end
  let(:jack) do
    User.create(username: 'Jack', email: 'jack@mail.com', password: 'jeeek')
  end

  let(:debt1) { Debt.new(debtor: bob, creditor: peter, amount: 20) }
  let(:debt2) { Debt.new(debtor: peter, creditor: bob, amount: 100) }
  let(:debt3) { Debt.new(debtor: bob, creditor: peter, amount: 60) }
  let(:debt4) { Debt.new(debtor: jack, creditor: peter, amount: 55.5) }
  let(:debt5) { Debt.new(debtor: bob, creditor: jack, amount: 20) }
  let(:debt6) { Debt.new(debtor: jack, creditor: bob, amount: 20) }
  let(:debts) { [debt1, debt2, debt3, debt4, debt5, debt6] }

  describe('#save_debts') do
    subject(:saved_debts) { debt_filter.save_debts(debts) }
    let(:expected_debt1) do
      Debt.new(debtor: peter, creditor: bob, amount: 20)
    end
    let(:expected_debt2) { debt4 }
    it 'saves debts after filtering them' do
      aggregate_failures 'testing debts' do
        expect(saved_debts.first).to(
          have_attributes(debtor: expected_debt1.debtor,
                          creditor: expected_debt1.creditor,
                          amount: expected_debt1.amount)
        )
        expect(saved_debts.second).to(
          have_attributes(debtor: expected_debt2.debtor,
                          creditor: expected_debt2.creditor,
                          amount: expected_debt2.amount)
        )
      end
    end
  end
end
