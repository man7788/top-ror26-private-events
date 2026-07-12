class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_user, only: [ :index, :new, :show ]
  before_action :set_events_timeline, only: [ :index ]

  def index
    @events = Event.all
  end

  def new
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

  def show
    @attended = EventAttendance.find_by(attendee_id: current_user.id, event_id: params[:id])
    @event_attendance = EventAttendance.new unless @attended

    @event = Event.where(id: params[:id]).first

    @attendees = []
    EventAttendance.where(event_id: params[:id]).includes(:attendee).each do |e|
      @attendees.push(e.attendee.email)
    end

    if @event.nil?
      redirect_to root_path, alert: "Event not found"
    end
  end

  private

  def set_events_timeline
    set_future_events
    set_past_events
  end

  def set_future_events
    @future_events = Event.where("event_date > ?", Time.now)
  end

  def set_past_events
    @past_events = Event.where("event_date < ?", Time.now)
  end

  def set_user
    @user = current_user
  end

  def event_params
    params.expect(event: [ :name, :event_date ])
  end
end
