require 'rails_helper'

describe "Merchant relationships" do
  it "returns a collection of items associated with that merchant" do
    merchant = create(:merchant)
    merchant2 = Merchant.create(name: "Person", created_at: Time.now, updated_at: Time.now)
    merchant.items.create(name: "Thing", description: "it is a thing", unit_price: 12.12, created_at: Time.now, updated_at: Time.now )
    merchant.items.create(name: "Different Thing", description: "it is a different thing", unit_price: 12.12, created_at: Time.now, updated_at: Time.now )
    merchant.items.create(name: "Another Different Thing", description: "it is another different thing", unit_price: 12.12, created_at: Time.now, updated_at: Time.now )
    Item.create(name: "Differenter Thing", description: "it is differenter thing", unit_price: 12.12, created_at: Time.now, updated_at: Time.now, merchant: merchant2)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "returns a collection of invoices accociated with that merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    merchant2 = Merchant.create(name: "Person", created_at: Time.now, updated_at: Time.now)
    merchant.invoices.create(customer: customer, status: "shipped", created_at: Time.now, updated_at: Time.now)
    merchant.invoices.create(customer: customer, status: "shipped", created_at: Time.now, updated_at: Time.now)
    merchant2.invoices.create(customer: customer, status: "shipped", created_at: Time.now, updated_at: Time.now)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end
end
