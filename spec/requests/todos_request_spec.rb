require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }

  let(:headers) { valid_headers }

  describe 'GET /todos' do
    before { get '/todos/', params: {}, headers: headers }

    it 'returns todos' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns a status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(JSON.parse(response.body)['id']).to eq(todo_id)
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_attributes) { { title: 'Learn Elm', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(JSON.parse(response.body)['title']).to eq('Learn Elm')
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }

      before { post '/todos', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(JSON.parse(response.body)['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
