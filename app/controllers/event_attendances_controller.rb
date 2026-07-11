class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(current_user.id)
    @event_attendance = @user.event_attendances.build(event_params)

    if @event_attendance.save
      redirect_to event_path(event_params[:event_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event_attendance: [ :event_id ])
  end
end
