class PlacesController < ApplicationController
  before_action :set_place, only: [ :edit, :update ]
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def show
    @place = Place.find(params[:id])
    @review = Review.new
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to place_path(@place)
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

  def search
    query = params[:query]
    @places = Place.where("name LIKE ?", "%#{query}%")
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :price, :photo, :photo_cache, :UV, :startlight, :satellite, :wifi, :earth_mailing, :astronaut_outfit, :crater, :freezing, :alien, :detox)
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
