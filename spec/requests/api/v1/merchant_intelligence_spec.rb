require 'rails_helper'

describe "merchant intelligence" do
  it "returns the top x merchants ranked by total revenue" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    item = merchant.items.create(name: "Differenter Thing", description: "it is differenter thing", unit_price: 100, created_at: Time.now, updated_at: Time.now)
    customer = create(:customer)
    invoice = merchant.invoices.create(customer: customer, status: "shipped", created_at: Time.now, updated_at: Time.now)
    invoice2 = merchant2.invoices.create(customer: customer, status: "shipped", created_at: Time.now, updated_at: Time.now)
    InvoiceItem.create(item: item, invoice: invoice, quantity: 10, unit_price: item.unit_price, created_at: Time.now, updated_at: Time.now)
    InvoiceItem.create(item: item, invoice: invoice2, quantity: 10, unit_price: item.unit_price, created_at: Time.now, updated_at: Time.now)

    x = 2
    # merchants = Merchant.all


    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    top_merchants = JSON.parse(merchant.total_revenue)
    expect(response).to be_success
    expect(top_merchants.count).to eq(2)
  end
end