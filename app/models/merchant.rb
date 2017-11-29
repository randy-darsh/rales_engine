class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(x)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
            .joins(invoices: [:transactions, :invoice_items])
            .merge(Transaction.unscoped.successful)
            .group(:id)
            .order("revenue DESC")
            .limit(x)
  end

  def self.most_items(x)
    select("merchants.*, sum(invoice_items.quantity) AS item_quantity")
            .joins(invoices: [:invoice_items])
            .group(:id)
            .order("item_quantity DESC")
            .limit(x)
  end

end
