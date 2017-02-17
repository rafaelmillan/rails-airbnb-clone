class ReservationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_reservation, only: [ :accept, :decline ]
  # user = User.first
  # UserMailer.welcome(user).deliver_now

  def create
    @reservation = Reservation.new
    @reservation.user = current_user
    @reservation.place = Place.find(params[:place_id])
    @reservation.save
    redirect_to user_path(current_user), notice: "Your booking was submitted and it's awaiting confirmation."
  end

  def accept
    @reservation.accept
    redirect_to user_path(@reservation.place.user.id)
  end

  def decline
    @reservation.decline
    redirect_to user_path(@reservation.place.user.id)
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # def reservation_params
  #   params.require(:reservation).permit(:user, :reservation)
  # end
end
