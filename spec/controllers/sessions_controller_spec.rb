require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }
    it { is_expected.to be_ok }
  end

  describe 'POST #create' do
    subject { post :create, params: { session: user_params } }
    let!(:existing_user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    context 'User Exists and Valid Password' do
      let(:user_params) { { email: 'bob@mail.com', password: '123' } }
      it { is_expected.to redirect_to(existing_user) }
    end

    context 'User Does Not Exist or Invalid Password' do
      let(:user_params) { { email: 'bobmail.com', password: '321' } }
      it { is_expected.to be_ok }
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }
    it { is_expected.to redirect_to(root_path) }
  end
end
