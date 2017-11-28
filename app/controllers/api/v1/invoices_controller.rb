class Api::V1::InvoicesController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.invoices.all
  end

  def show
  end

end
