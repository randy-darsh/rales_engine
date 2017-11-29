class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.most_revenue(params[:quantity])
  end

  def show
    total_rev = Merchant.total_revenue(filter)
    render json: total_rev, :serializer => RevenueSerializer
  end

  private

  def filter
    params.permit(:id, :date)
  end
  
end