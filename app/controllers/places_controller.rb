class PlacesController < ApplicationController
  before_action :set_place, only: [ :edit, :update ]

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def show
    @place = Place.find(params[:id])
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to place_path(@place)
    else
      render :edit
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :price)
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
