require 'rails_helper'

describe "merchants API" do
  before :each do
    create_list(:merchant, 3)
  end
  it "creates a list of merchants" do
    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it 'can find merchant by id params' do
    get "/api/v1/merchants/find?id=8"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(8)
  end

  it 'can find merchant by name params' do
    get "/api/v1/merchants/find?name=MyString"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["name"]).to eq("MyString")
  end

  it 'can find merchant by date params' do
    get "/api/v1/merchants/find?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(2)

    get "/api/v1/merchants/find?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(2)
  end

  it 'can find all merchants by id' do
    get "/api/v1/merchants/find_all?id=17"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.first["id"]).to eq(17)
  end

  it 'can find all merchants by name params' do
    get "/api/v1/merchants/find_all?name=MyString"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.first["name"]).to eq("MyString")
  end

  it 'can find all merchants by date params' do
    get "/api/v1/merchants/find_all?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)

    get "/api/v1/merchants/find_all?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)
  end
end
