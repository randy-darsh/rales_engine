require 'rails_helper'

describe "invoice_items API" do
  before :each do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:invoice_item, 3, invoice: invoice, item: item, unit_price: 10)
  end

  it "creates a list of invoice_items" do
    get '/api/v1/invoice_items'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)
  end

  it "can get one invoice_item by its id" do
    get '/api/v1/invoice_items/5'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(5)
  end

  it 'can find invoice_item by id params' do
    get "/api/v1/invoice_items/find?id=8"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(8)
  end

  it 'can find invoice_item by quantity params' do
    get "/api/v1/invoice_items/find?quantity=2"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it "can find invoice_item by unit price" do
    get "/api/v1/invoice_items/find?unit_price=10"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it 'can find invoice_item by date params' do
    get "/api/v1/invoice_items/find?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)

    get "/api/v1/invoice_items/find?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end
end