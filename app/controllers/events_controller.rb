class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @user = current_user
    @events = Event.all
  end

  def new
    @user = current_user
    @event = Event.new
  end

  def create
    @user = User.find(current_user.id)
    @event = @user.events.build(event_params)
    @event.creator_id = @user.id

    if @event.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event: [ :name, :event_date ])
  end
end
