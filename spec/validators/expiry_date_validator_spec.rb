require 'rails_helper'

RSpec.describe ExpiryDateValidator, type: :validator do
  describe('#validate') do
    subject { bet }
    let(:user) do
      User.create(username: 'Ivan',
                  email: 'imustbreakyou@mail.com',
                  password: 'hammerandsickle')
    end
    let(:bet) do
      Bet.new(description: 'Test bet',
              creator_id: user.id,
              expires_at: expiry_date)
    end
    context 'valid expiry date' do
      let(:expiry_date) { DateTime.tomorrow }
      it { is_expected.to be_valid }
    end
    context 'invalid expiry date' do
      let(:expiry_date) { DateTime.yesterday }
      it { is_expected.to_not be_valid }
    end
  end
end
