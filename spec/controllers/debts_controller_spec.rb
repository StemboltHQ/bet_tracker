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
  end
end
