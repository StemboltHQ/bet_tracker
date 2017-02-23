require 'rails_helper'

RSpec.describe Bet, type: :model do
  let!(:bob) do
    User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
  end
  let!(:peter) do
    User.create(username: 'Peter', email: 'peter@mail.com', password: 'pete1')
  end
  let!(:jack) do
    User.create(username: 'Jack', email: 'jack@mail.com', password: 'notjack')
  end

  let(:bet1) do
    Bet.create(bet: 'Superbowl: Atlanta vs New England, place your bets!')
  end
  let(:option1) { BetOption.create(option_text: 'Atlanta wins') }
  let(:option2) { BetOption.create(option_text: 'New England wins') }

  let!(:users_place_bets) do
    UserBet.create(user:       bob,
                   bet:        bet1,
                   bet_option: option1,
                   amount_bet: 100)

    UserBet.create(user:       peter,
                   bet:        bet1,
                   bet_option: option1,
                   amount_bet: 50)

    UserBet.create(user:       jack,
                   bet:        bet1,
                   bet_option: option2,
                   amount_bet: 300)
  end

  describe('#resolve') do
    subject(:debts) { bet1.resolve(winning_option: option) }
    let(:option) { option1 }
    it 'is an array of debts' do
      expect(debts).to all be_a Debt
    end

    context 'Atlanta wins' do
      let(:expected_debt) do
        Debt.find_by!(debtor: jack, creditor: bob, amount: 201)
      end
      it 'contains the correct debts' do
        expect(debts).to include expected_debt
      end
    end

    context 'New England wins' do
      let(:expected_debt) do
        Debt.find_by!(debtor: bob, creditor: jack, amount: 100)
      end
      let(:option) { option2 }
      it 'contains the correct debts' do
        expect(debts).to include expected_debt
      end
    end
  end
end
