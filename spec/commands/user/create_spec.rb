require 'rails_helper'

RSpec.describe User::Create do
  describe '#call' do
    subject { User::Create.new(user_params).call }

    context 'when password is correct' do
      let(:user_params) { { email: 'user1@example.com', password: 'password', password_confirmation: 'password' } }

      it 'creates a user' do
        expect{ subject }.to change{ User.count }.by(1)
      end
    end

    context 'when passwords dont match' do
      let(:user_params) { { email: 'user1@example.com', password: 'password', password_confirmation: 'pazsword' } }

      it 'raises validation error' do
        expect{ subject }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end
