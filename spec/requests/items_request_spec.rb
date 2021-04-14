require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all todo items' do
        expect(JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when the todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the item' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before { post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request attributes are invalid' do
      before { post "/todos/#{todo_id}/items", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
