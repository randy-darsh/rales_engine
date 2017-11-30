class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.all
  end

  def show
    ii = InvoiceItem.find(params[:id])
    render json: ii, :serializer => InvoiceItemSerializer
  end

end
