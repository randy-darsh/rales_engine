require 'rails_helper'

describe "transactions API" do
  before :each do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:invoice_item, 3, invoice: invoice, item: item, unit_price: 10)
    create_list(:transaction, 5, invoice: invoice)
  end

  it "creates a list of transactions" do
    get "/api/v1/transactions"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it "can get one transaction by its id" do
    get '/api/v1/transactions/6'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(6)
  end

  it 'can find transaction by id params' do
    get "/api/v1/transactions/find?id=11"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(11)
  end

  it 'can find transaction by credit_card_number params' do
    get "/api/v1/transactions/find?credit_card_number=5"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(4)
  end

  it "can find transaction by result params" do
    get "/api/v1/transactions/find?result=success"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(4)
  end

  it 'can find transaction by date params' do
    get "/api/v1/transactions/find?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(4)

    get "/api/v1/transactions/find?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(4)
  end
end
