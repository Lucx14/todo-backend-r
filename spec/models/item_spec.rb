require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to(:todo) }

  it { is_expected.to validate_presence_of(:name) }
end
