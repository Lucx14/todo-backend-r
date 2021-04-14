require 'rails_helper'

RSpec.describe AuthenticateUser do
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }

  let(:user) { create(:user) }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return a token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }.to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
    end
  end
end
