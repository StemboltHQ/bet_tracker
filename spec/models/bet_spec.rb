require 'rails_helper'

RSpec.describe Bet, type: :model do
  let(:bob) do
    User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
  end
  let(:peter) do
    User.create(username: 'Peter', email: 'peter@mail.com', password: 'pete1')
  end
  let(:jack) do
    User.create(username: 'Jack', email: 'jack@mail.com', password: 'notjack')
  end

  let(:bet1) do
    Bet.create(description: 'Superbowl: Atlanta vs New England, '\
               'place your bets!',
               expires_at: DateTime.tomorrow, creator_id: bob.id)
  end
  let(:option1) { BetOption.create(option_text: 'Atlanta wins', bet: bet1) }
  let(:option2) do
    BetOption.create(option_text: 'New England wins', bet: bet1)
  end
  let(:bob_bets_100_on_option1) do
    UserBet.create(user:       bob,
                   bet:        bet1,
                   bet_option: option1,
                   amount_bet: 100)
  end
  let(:peter_bets_50_on_option1) do
    UserBet.create(user:       peter,
                   bet:        bet1,
                   bet_option: option1,
                   amount_bet: 50)
  end
  let(:jack_bets_300_on_option2) do
    UserBet.create(user:       jack,
                   bet:        bet1,
                   bet_option: option2,
                   amount_bet: 300)
  end
  let!(:users_place_bets) do
    bob_bets_100_on_option1
    peter_bets_50_on_option1
    jack_bets_300_on_option2
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

  describe('#bet_total') do
    subject { bet1.bet_total }
    let(:expected_bet_total) { 450 }
    it { is_expected.to eq expected_bet_total }
  end

  describe('#winner_total') do
    subject { bet1.winner_total }
    let!(:winning_option) { option1.update(winner: true) }
    let(:expected_winner_total) { 150 }
    it { is_expected.to eq expected_winner_total }
  end

  describe('#amount_owed') do
    subject { bet1.amount_owed(lost_bet, won_bet) }
    let!(:winning_option) { option2.update(winner: true) }
    let(:lost_bet) { bob_bets_100_on_option1 }
    let(:won_bet) { jack_bets_300_on_option2 }
    let(:expected_amount_owed) { 100 }
    it { is_expected.to eq expected_amount_owed }
  end

  describe('#created_by?') do
    subject { bet1.created_by?(user) }
    context 'the bet was created by the user Bob' do
      let(:user) { bob }
      it { is_expected.to be true }
    end
    context 'the bet was not created by the user Jack' do
      let(:user) { jack }
      it { is_expected.to be false }
    end
  end
end
