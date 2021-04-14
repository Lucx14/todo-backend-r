require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        expect(JSON.parse(response.body)['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns failure message' do
        expected = [
          "Validation failed: Password can't be blank",
          "Name can't be blank",
          "Email can't be blank",
          "Password digest can't be blank"
        ].join(', ')
        expect(JSON.parse(response.body)['message']).to match(expected)
      end
    end
  end
end
