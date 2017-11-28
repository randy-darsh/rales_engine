class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # def top_total_revenues(x)
  #   Merchant.

  #   .order( DESC)
  #   .take(x)
  # end

end
