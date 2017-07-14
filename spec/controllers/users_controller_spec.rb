require 'rails_helper'

RSpec.describe UsersController do
  describe '#create' do
    subject { post :create, params: params }

    context 'when params are valid' do
      let(:params) { { email: 'user1@example.com', password: 'password', password_confirmation: 'password' } }

      it 'redirects to root' do
        subject
        expect(response).to redirect_to('/')
      end
    end

    context 'when passwords dont match' do
      let(:params) { { email: 'user1@example.com', password: 'password', password_confirmation: 'word' } }

      it 'renders #new' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
