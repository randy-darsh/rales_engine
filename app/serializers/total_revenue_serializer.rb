class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object.values.first / 100.to_f).to_s
  end
  
end
