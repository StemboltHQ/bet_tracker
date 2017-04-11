require 'rails_helper'

RSpec.describe DebtsController, type: :controller do
  describe('GET #index') do
    subject { get :index, params: { user_id: current_user.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com',
                  password: '123')
    end
    before { log_in(user) }
    it { is_expected.to be_ok }
  end

  describe('PATCH #update') do
    subject(:patch_update) do
      patch :update, params: { user_id: debtor.id, bet_id: bet.id,
                               id: debt.id }
    end
    let(:debtor) do
      User.create(username: 'Pete', email: 'pete@mail.com',
                  password: '321')
    end
    let(:creditor) do
      User.create(username: 'Jack', email: 'jack@mail.com',
                  password: 'j4cK')
    end
    let(:bet) do
      Bet.create(description: 'Test bet', status: '1', creator_id: creditor.id,
                 expires_at: DateTime.tomorrow)
    end
    let(:debt) do
      Debt.create(debtor: debtor, creditor: creditor, amount: 50, bet: bet)
    end
    it { is_expected.to redirect_to bet }
    it 'changes the payment date for the debt' do
      expect { patch_update }.to change { debt.reload.payment_date }.from(nil)
    end
  end
end
