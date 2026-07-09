class UsersController < ApplicationController
  def show
    @events = Event.where(creator: params[:id])
  end
end
