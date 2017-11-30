class Api::V1::Invoices::ItemsController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.items
  end

end