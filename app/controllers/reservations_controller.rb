class ReservationsController < ApplicationController
  before_action :set_place, only: [ :create ]

  def create
    @reservation = Reservation.new
    @reservation.user = current_user
    @reservation.place = @place
    if @reservation.save
      redirect_to 'root' # Change once we create a users#show
    else
      render "pages/reservation"
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end
end
