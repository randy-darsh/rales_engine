class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object.values.first / 100.to_f).to_s
  end

end
