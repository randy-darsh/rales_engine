class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :trasactions, through: :invoices
  has_many :invoice_items, through: :invoices

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
            .joins(invoices: [:transactions, :invoice_items])
            .merge(Transaction.unscoped.successful)
            .group(:id)
            .order("item_quantity DESC")
            .limit(x)
  end

  def self.total_revenue(filter = nil)
    if filter[:date]
      joins(invoices: [:transactions, :invoice_items])
          .merge(Transaction.unscoped.successful)
          .where(invoices: {created_at: filter[:date]})
          .group(:id)
          .sum("(invoice_items.quantity * invoice_items.unit_price)")
    else
      joins(invoices: [:transactions, :invoice_items])
          .merge(Transaction.unscoped.successful)
          .where(id: filter[:id])
          .group(:id)
          .sum("(invoice_items.quantity * invoice_items.unit_price)")
    end
  end

  def self.total_rev_by_date(x = nil)
      joins(invoices: [:transactions, :invoice_items])
          .merge(Transaction.unscoped.successful)
          .group("created_at")
          .where(invoices: {created_at: x})
          .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def favorite_customer
    customers
        .select('customers.*, count(transactions) AS transaction_count')
        .joins(:transactions)
        .merge(Transaction.unscoped.successful)
        .group('customers.id')
        .order("transaction_count DESC")
        .first
  end

end
