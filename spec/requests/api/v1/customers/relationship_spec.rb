require 'rails_helper'

describe "customer relationships" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)    
    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)    
    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer2)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer3)
    @transaction1 = create(:transaction, invoice: @invoice1)
    @transaction2 = create(:transaction, invoice: @invoice1)
    @transaction3 = create(:transaction, invoice: @invoice3)
    @transaction4 = create(:transaction, invoice: @invoice1)
    @transaction5 = create(:transaction, invoice: @invoice2)
    @transaction6 = create(:transaction, invoice: @invoice3)
    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: @item1.unit_price)
    @invoice_item2 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: @item1.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item2, invoice: @invoice1, unit_price: @item2.unit_price)
    @invoice_item4 = create(:invoice_item, item: @item2, invoice: @invoice2, unit_price: @item2.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item2, invoice: @invoice3, unit_price: @item2.unit_price)
    @invoice_item6 = create(:invoice_item, item: @item2, invoice: @invoice3, unit_price: @item2.unit_price)
  end

  it 'returns a collection of associated invoices' do
    get "/api/v1/customers/#{@customer1.id}/invoices"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.first["id"]).to eq(1)
  end

  it "returns a collection of associated transactions" do
    get "/api/v1/customers/#{@customer1.id}/transactions"

    expect(response).to be_success

    x = JSON.parse(response.body)

    expect(x.first["id"]).to eq(7)
  end
end
