require 'rails_helper'
require 'pry'

RSpec.describe BetsHelper, type: :helper do
  let(:user1) do
    User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
  end
  let(:user2) do
    User.create(username: 'Jack', email: 'jack@mail.com', password: 'jackkkk')
  end
  let(:bet) do
    Bet.create(bet: 'Test bet',
               expires_at: DateTime.tomorrow,
               creator: creator,
               active: active_status)
  end

  describe '#creator?' do
    subject { creator? }
    context 'current user is the bet creator' do
      before { log_in(user1) }
      let(:creator) { user1 }
      let(:active_status) { true }
      it 'is expected to be true' do
        @bet = bet
        is_expected.to be true
      end
    end

    context 'current user is not the bet creator' do
      before { log_in(user1) }
      let(:creator) { user2 }
      let(:active_status) { true }
      it 'is expected to be false' do
        @bet = bet
        is_expected.to be false
      end
    end
  end

  describe '#resolved?' do
    subject { resolved? }
    context 'bet has been resolved' do
      let(:creator) { user1 }
      let(:active_status) { true }
      it 'is expected to be true' do
        @bet = bet
        is_expected.to be true
      end
    end
    context 'bet has not been resolved' do
      let(:creator) { user1 }
      let(:active_status) { false }
      it 'is expected to be false' do
        @bet = bet
        is_expected.to be false
      end
    end
  end
end
