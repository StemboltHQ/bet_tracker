require 'rails_helper'

RSpec.describe BetOptionsController, type: :controller do
  describe 'GET #new' do
    subject { get :new, params: { bet_id: bet.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    let(:bet) do
      Bet.create(bet: 'Bet text',
                 expires_at: DateTime.tomorrow,
                 creator_id: user.id)
    end
    context 'user is logged in' do
      before { log_in(user) }
      it { is_expected.to be_ok }
    end
    context 'user is not logged in' do
      it { is_expected.to redirect_to new_session_path }
    end
  end
end
