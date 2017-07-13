require 'rails_helper'

RSpec.describe User::Authenticate do
  let!(:user) { User::Create.new(email: 'user1@example.com', password: 'password', password_confirmation: 'password').call }

  describe '#call' do
    subject { User::Authenticate.new(user, password).call }

    context 'when password is correct' do
      let(:password) { 'password' }

      it { is_expected.to be true }
    end

    context 'when password is incorrect' do
      let(:password) { 'nonsense' }

      it { is_expected.to be false }
    end
  end
end
