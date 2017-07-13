require 'rails_helper'

RSpec.describe User::SessionTokenGenerator do
  let!(:user) { User::Create.new(email: 'user1@example.com', password: 'password', password_confirmation: 'password').call }
  describe '#call' do
    subject { User::SessionTokenGenerator.new(user).call }

    it 'changes the user session token' do
      expect{ subject }.to change{ user.reload.session_token }
    end
  end
end
