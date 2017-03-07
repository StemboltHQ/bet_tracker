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
  let(:option1) { BetOption.create(option_text: 'Atlanta wins', bet: bet1) }
  let(:option2) { BetOption.create(option_text: 'New England wins', bet: bet1) }

  let(:nick) do
    User.create(username: 'Nick', email: 'secret@mail.com', password: 'nini')
  end
  let(:morgan) do
    User.create(username: 'Morgan', email: 'jolly@roger.com', password: 'yarr')
  end

  let(:bet2) do
    Bet.create(bet: 'Ninjas vs Pirates')
  end
  let(:option3) { BetOption.create(option_text: 'Ninjas win', bet: bet2) }
  let(:option4) { BetOption.create(option_text: 'Pirates win', bet: bet2) }

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

    UserBet.create(user:       nick,
                   bet:        bet2,
                   bet_option: option3,
                   amount_bet: 100)

    UserBet.create(user:       nick,
                   bet:        bet2,
                   bet_option: option4,
                   amount_bet: 50)

    UserBet.create(user:       morgan,
                   bet:        bet2,
                   bet_option: option3,
                   amount_bet: 20)

    UserBet.create(user:       morgan,
                   bet:        bet2,
                   bet_option: option4,
                   amount_bet: 200)
  end

  describe('#resolve') do
    subject(:debts) { bet.resolve(winning_option: option) }
    context 'user bets on only one option' do
      let(:bet) { bet1 }
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
        let(:option) { option2 }
        let(:expected_debt) do
          Debt.find_by!(debtor: bob, creditor: jack, amount: 100)
        end
        it 'contains the correct debts' do
          expect(debts).to include expected_debt
        end
      end
    end

    context 'user bets on multiple options' do
      let(:bet) { bet2 }

      let(:option) { option3 }
      it 'is an array of debts' do
        expect(debts).to all be_a Debt
      end

      context 'Ninjas win' do
        let(:expected_debt1) do
          Debt.find_by!(debtor: morgan, creditor: nick, amount: 166)
        end
        let(:expected_debt2) do
          Debt.find_by!(debtor: nick, creditor: morgan, amount: 8.5)
        end
        it 'contains the correct debts' do
          aggregate_failures do
            expect(debts).to include expected_debt1
            expect(debts).to include expected_debt2
          end
        end
      end

      context 'Pirates win' do
        let(:option) { option4 }
        let(:expected_debt1) do
          Debt.find_by!(debtor: morgan, creditor: nick, amount: 4)
        end
        let(:expected_debt2) do
          Debt.find_by!(debtor: nick, creditor: morgan, amount: 80)
        end
        it 'contains the correct debts' do
          aggregate_failures do
            expect(debts).to include expected_debt1
            expect(debts).to include expected_debt2
          end
        end
      end
    end
  end

  describe('#bet_total') do
    subject { bet1.bet_total }

    let(:expected_bet_total) { 450 }
    it { is_expected.to eq expected_bet_total }
  end
end
