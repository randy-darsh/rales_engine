class Api::V1::Merchants::InvoiceRelationshipController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant.invoices.all
  end

end