class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :unit_price, :merchant_id
end
