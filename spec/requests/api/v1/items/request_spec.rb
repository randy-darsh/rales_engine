require 'rails_helper'

describe "items API" do
  before :each do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant, unit_price: 10)
  end

  it "creates a list of items" do
    get "/api/v1/items"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it "can get one item by its id" do
    get '/api/v1/items/6'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(6)
  end

  it 'can find item by id params' do
    get "/api/v1/items/find?id=11"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(11)
  end

  it 'can find item by description params' do
    get "/api/v1/items/find?description=MyText"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it "can find item by unit_price params" do
    get "/api/v1/items/find?unit_price=10"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end

  it 'can find item by date params' do
    get "/api/v1/items/find?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)

    get "/api/v1/items/find?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(5)
  end
end
