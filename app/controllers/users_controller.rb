class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
    @places = @user.places
    # Reservations for my properties
    @reservations_for_me = @user.places.map { |res| res.reservations }
    @reservations_for_me.flatten!
    # Reservations I made
    @reservations_i_made = @user.reservations
  end
end
