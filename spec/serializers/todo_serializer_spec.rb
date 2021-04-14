# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoSerializer do
  subject(:serialized_todo) { JSON.parse(described_class.new(todo).to_json) }

  let(:todo) { build_stubbed(:todo) }

  it {
    expected_keys = %w[
      id title created_by items created_at updated_at
    ].sort
    expect(serialized_todo.keys.sort).to eq(expected_keys)
  }

  it { expect(serialized_todo['id']).to eq(todo.id) }
  it { expect(serialized_todo['title']).to eq(todo.title) }
  it { expect(serialized_todo['created_by']).to eq(todo.created_by) }
  it { expect(serialized_todo['items']).to eq(todo.items) }
end
