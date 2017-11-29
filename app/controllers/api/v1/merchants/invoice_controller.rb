class Api::V1::Merchants::InvoiceController < ApplicationController

  def index
    rev_by_date = Merchant.total_rev_by_date(params[:date])
    render json: rev_by_date, :serializer => TotalRevenueSerializer
  end

end