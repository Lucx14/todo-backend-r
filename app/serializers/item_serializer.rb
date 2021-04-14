class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :todo_id, :created_at, :updated_at
end
