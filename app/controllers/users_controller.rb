class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = current_user
    @events = Event.where(creator: params[:id])
  end
end
