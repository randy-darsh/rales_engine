require 'rails_helper'

describe "Merchant relationships" do
  it "returns a collection of items associated with that merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)
    
    get "/api/v1/merchants/:id/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

end