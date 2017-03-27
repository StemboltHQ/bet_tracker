require 'rails_helper'

RSpec.describe BetsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }
    it { is_expected.to be_ok }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: bet.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    let(:bet) do
      Bet.create(bet: 'Bet text',
                 expires_at: DateTime.tomorrow,
                 creator_id: user.id)
    end
    it { is_expected.to be_ok }
  end

  describe 'GET #new' do
    subject { get :new }
    it { is_expected.to be_ok }
  end

  describe 'POST #create' do
    subject(:post_create) { post :create, params: { bet: bet_params } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    context 'with valid params' do
      let(:bet_params) do
        { bet: 'Bet text',
          expires_at: DateTime.tomorrow,
          creator_id: user.id }
      end
      let(:created_bet) { Bet.last }
      it 'creates a new bet in the database' do
        expect { post_create }.to change(Bet, :count).by(1)
      end
      it { is_expected.to redirect_to(created_bet) }
    end
    context 'with invalid params' do
      let(:bet_params) do
        { bet: 'Invalid Bet',
          expires_at: DateTime.yesterday,
          creator_id: user.id }
      end
      it 'changes the flash[:danger] message' do
        expect { post_create }.to change { flash[:danger] }
      end
      it 'does not create new bets in the database' do
        expect { post_create }.to_not change(Bet, :count)
      end
      it { is_expected.to be_ok }
    end
  end
end
