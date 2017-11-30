require 'rails_helper'

describe "customers API" do
  before :each do
    create_list(:customer, 3)
  end

  it "creates a list of customers" do
    get '/api/v1/customers'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)
  end

  it "can get one customer by its id" do
    get '/api/v1/customers/5'

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(5)
  end

  it 'can find customer by id params' do
    get "/api/v1/customers/find?id=8"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["id"]).to eq(8)
  end

  it 'can find customer by name params' do
    get "/api/v1/customers/find?first_name=MyString"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["first_name"]).to eq("MyString")

    get "/api/v1/customers/find?last_name=MyString"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x["last_name"]).to eq("MyString")
  end

  it 'can find customer by date params' do
    get "/api/v1/customers/find?created_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)

    get "/api/v1/customers/find?updated_at='2017-11-28 14:17:58'"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.count).to eq(3)
  end
end
