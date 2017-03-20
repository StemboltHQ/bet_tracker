require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) do
    User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
  end

  describe '#log_in' do
    subject { log_in(user) }
    it { is_expected.to eq user }
  end

  describe '#current_user' do
    subject { current_user }
    before { log_in(user) }
    it { is_expected.to eq user }
  end

  describe '#log_out' do
    subject { log_out }
    before { log_in(user) }
    it 'changes session[:user_id] to nil' do
      expect { subject }.to change { session[:user_id] }.to(nil)
    end
    it 'changes the current user to nil' do
      expect { subject }.to change { @current_user }.from(@current_user).to(nil)
    end
  end
end
