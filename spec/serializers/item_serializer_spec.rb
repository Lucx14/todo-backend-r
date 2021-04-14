# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemSerializer do
  subject(:serialized_item) { JSON.parse(described_class.new(item).to_json) }

  let(:item) { build_stubbed(:item) }

  it {
    expected_keys = %w[
      id name done todo_id created_at updated_at
    ].sort
    expect(serialized_item.keys.sort).to eq(expected_keys)
  }

  it { expect(serialized_item['id']).to eq(item.id) }
  it { expect(serialized_item['name']).to eq(item.name) }
  it { expect(serialized_item['done']).to eq(item.done) }
  it { expect(serialized_item['todo_id']).to eq(item.todo_id) }
end
