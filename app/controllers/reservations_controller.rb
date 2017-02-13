class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new
    @reservation.user = current_user
    @reservation.place = Place.find(params[:place_id])
    @reservation.save
    redirect_to root_path # Change once we create a users#show
  end
end
