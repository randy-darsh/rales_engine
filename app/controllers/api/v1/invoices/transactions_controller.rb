class Api::V1::Invoices::TransactionsController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.transactions
  end

end
