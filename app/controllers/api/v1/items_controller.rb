class Api::V1::ItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.items.all
  end

  def show
  end

end
