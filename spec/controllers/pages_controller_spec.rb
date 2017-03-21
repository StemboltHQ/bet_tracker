require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #index' do
    subject { get :index }
    it { is_expected.to be_ok }
  end
end
