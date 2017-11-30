class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(x)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(x)
  end
end
