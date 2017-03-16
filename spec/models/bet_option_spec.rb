require 'rails_helper'

RSpec.describe BetOption, type: :model do
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

  describe('#option_total') do
    subject { winning_option.option_total }

    context 'Atlanta wins' do
      let(:option1) do
        BetOption.create(option_text: 'Atlanta wins', winner: true)
      end
      let(:option2) { BetOption.create(option_text: 'New England wins') }
      let(:winning_option) { option1 }
      let(:expected_total) { 150 }
      xit 'returns the total amount bet by all users on the winning option' do
        expect(subject).to eq expected_total
      end
    end

    context 'New England wins' do
      let(:option1) { BetOption.create(option_text: 'Atlanta wins') }
      let(:option2) do
        BetOption.create(option_text: 'New England wins', winner: true)
      end
      let(:winning_option) { option2 }
      let(:expected_total) { 300 }
      xit 'returns the total amount bet by all users on the winning option' do
        expect(subject).to eq expected_total
      end
    end
  end
end
