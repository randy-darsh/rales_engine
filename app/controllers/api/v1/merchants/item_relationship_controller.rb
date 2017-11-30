class Api::V1::Merchants::ItemRelationshipController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant.items.all
  end

end