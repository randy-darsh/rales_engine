require 'rails_helper'

describe "merchant intelligence" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @customer = create(:customer)
    item = create(:item, merchant: @merchant1)
    invoice1 = create(:invoice, merchant: @merchant1, customer: @customer)
    invoice2 = create(:invoice, merchant: @merchant2, customer: @customer)
    invoice3 = create(:invoice, merchant: @merchant3, customer: @customer)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    transaction4 = create(:transaction, invoice: invoice1)
    transaction5 = create(:transaction, invoice: invoice2)
    transaction6 = create(:transaction, invoice: invoice3)
    create(:invoice_item, item: item, invoice: invoice1, unit_price: item.unit_price)
    create(:invoice_item, item: item, invoice: invoice1, unit_price: item.unit_price)
    create(:invoice_item, item: item, invoice: invoice2, unit_price: item.unit_price)
    create(:invoice_item, item: item, invoice: invoice2, unit_price: item.unit_price)
    create(:invoice_item, item: item, invoice: invoice3, unit_price: item.unit_price)
    create(:invoice_item, item: item, invoice: invoice3, unit_price: item.unit_price)
  end

  it "returns the top x merchants ranked by total revenue" do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(2)
    expect(x.first["id"]).to eq(@merchant1.id)
    expect(x.last["id"]).to eq(@merchant2.id)
  end

  it "returns the top x merchants ranked by total number of items sold" do
    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(2)
    expect(x.first["id"]).to eq(@merchant1.id)
    expect(x.last["id"]).to eq(@merchant2.id)
  end

  it "returns the total revenue for date x across all merchants" do
    get '/api/v1/merchants/revenue?date="2017-11-28 14:17:58"'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["total_revenue"]).to eq("0.36")
  end

  it "returns the total revenue for that merchant across successful transactions" do
    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["revenue"]).to eq("0.12")
  end

  it "returns the total revenue for that merchant for a specific invoice date x" do
    get "/api/v1/merchants/#{@merchant1.id}/revenue?date='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["revenue"]).to eq("0.12")
  end

  it "returns the customer who has conducted the most total number of successful transactions" do
    get "/api/v1/merchants/#{@merchant1.id}/favorite_customer"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(@customer.id)
  end
end