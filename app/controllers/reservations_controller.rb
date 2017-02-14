class ReservationsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @reservation = Reservation.new
    @reservation.user = current_user
    @reservation.place = Place.find(params[:place_id])
    @reservation.save
    redirect_to root_path # Change once we create a users#show
  end
end
