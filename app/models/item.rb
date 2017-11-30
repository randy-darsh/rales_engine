class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.most_revenue(x)
    unscoped.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(x)
  end

  def self.most_items(x)
    unscoped.select("items.*, sum(invoice_items.quantity) AS amount_sold")
      .joins(invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("amount_sold DESC")
      .limit(x)
  end
end
