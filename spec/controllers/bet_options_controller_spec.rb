require 'rails_helper'

RSpec.describe BetOptionsController, type: :controller do
  describe 'GET #new' do
    subject { get :new, params: { bet_id: bet.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    let(:bet) do
      Bet.create(description: 'Bet text',
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

  describe 'POST #create' do
    subject do
      post :create, params: { bet_id: bet_id, bet_option: bet_option_params }
    end
    let(:bet_option_params) do
      { option_text: 'bet option text' }
    end
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    let(:bet) do
      Bet.create(description: 'Bet text',
                 expires_at: DateTime.tomorrow,
                 creator_id: user.id)
    end
    context 'with valid params' do
      before { log_in(user) }
      let(:bet_id) { bet.id }
      it { is_expected.to redirect_to bet }
    end
  end
end
