class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @events = Event.where(creator: params[:id])
    @attended_events = User.where(id: current_user.id).first.attended_events
  end
end
