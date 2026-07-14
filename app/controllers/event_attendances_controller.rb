class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by(email: event_params[:user_email])

    unless @user
      redirect_to event_path(event_params[:event_id]), alert: "User not found" and return
    end

    @event_attendance = @user.event_attendances.build(attendee_id: @user.id, event_id: event_params[:event_id])

    if @event_attendance.save
      redirect_to event_path(event_params[:event_id])
    else
      redirect_to event_path(event_params[:event_id]), alert: "Something went wrong"
    end
  end

  private

  def event_params
    params.expect(event_attendance: [ :event_id, :user_email ])
  end
end
