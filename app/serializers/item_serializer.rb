class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :unit_price, :merchant_id

  def unit_price
    (object.unit_price / 100).to_s
  end
end
