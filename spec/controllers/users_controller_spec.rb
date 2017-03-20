require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    subject { get :index }
    it { is_expected.to be_ok }
  end

  describe 'GET #new' do
    subject { get :new }
    it { is_expected.to be_ok }
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    context 'user is logged in' do
      before { log_in(user) }
      it { is_expected.to be_ok }
    end

    context 'user is not logged in' do
      it { is_expected.to redirect_to(new_session_path) }
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: user.id } }
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    it { is_expected.to be_ok }
  end

  describe 'POST #create' do
    subject(:post_create) { post :create, params: { user: user_params } }
    context 'with valid params' do
      let(:user_params) do
        { username: 'Bob', email: 'bob@mail.com', password: '123' }
      end
      let(:created_user) { User.last }
      it 'creates a new User in the database' do
        expect { post_create }.to change(User, :count).by(1)
      end
      it { is_expected.to redirect_to(created_user) }
    end
    context 'with invalid params' do
      let(:user_params) { { age: 35 } }
      it 'does not create a new User in the database' do
        expect { post_create }.to_not change(User, :count)
      end
      it { is_expected.to be_ok }
    end
  end

  describe 'PATCH #update' do
    subject(:patch_update) do
      patch :update, params: { id: user.id, user: updated_params }
    end
    let(:user) do
      User.create(username: 'Bob', email: 'bob@mail.com', password: '123')
    end
    context 'with valid params' do
      before { log_in(user) }
      let(:updated_params) { { username: 'Robert' } }
      it 'changes username for User' do
        expect { patch_update }.to change { user.reload.username }
      end
      it { is_expected.to redirect_to(user) }
    end
  end
end
