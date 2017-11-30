class Api::V1::Items::ItemController < ApplicationController

  def index
    render json: Item.most_items(params[:quantity])
  end

  def show
    render json: {best_day: Item.find(params[:id]).best_day}
  end

end
