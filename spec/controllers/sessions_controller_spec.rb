require 'rails_helper'

RSpec.describe SessionsController do
  let!(:user) { User::Create.new(email: 'user1@example.com', password: 'password', password_confirmation: 'password').call }

  describe '#create' do
    subject { post :create, params: params }

    context 'when user is not signed in' do
      let(:params) { { email: user.email, password: 'password' } }

      it 'redirects to root' do
        subject
        expect(response).to redirect_to('/')
      end
    end

    context 'when user tries to login as a non-existent user' do
      let(:params) { { email: 'user6@bullshit.com', password: 'password' } }

      it 'renders #new' do
        subject
        expect(response).to render_template(:new)
      end
    end

    context 'when user tries to login providing invalid password' do
      let(:params) { { email: user.email, password: 'invalid-password' } }

      it 'renders #new' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#logout' do
    subject { delete :destroy }

    context 'when user is signed in' do
      before do
        sign_in user
      end

      it 'redirects to root' do
        subject
        expect(response).to redirect_to('/')
      end
    end
  end
end
