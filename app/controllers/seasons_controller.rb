class SeasonsController < ApplicationController
  def index
    @seasons = Season.all.order(:id)
  end
end
