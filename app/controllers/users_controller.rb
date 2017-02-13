class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @places = @user.places
  end
end
