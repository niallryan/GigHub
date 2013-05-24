class UserEventAttendancesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @user_event_attendance = UserEventAttendance.new(event: @event, user: current_user)
    else
      flash[:error] = "Event Required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_event_attendance] && params[:user_event_attendance].has_key?(:event_id)
      @event = Event.find(params[:user_event_attendance][:event_id])
      @user_event_attendance = UserEventAttendance.new(event: @event, user: current_user)
      @user_event_attendance.save
      flash[:success] = "You are now attending #{@event.name}."
      redirect_to event_path(@event)
    else
      flash[:error] = "Event Required"
      redirect_to root_path
    end

  end

  def index
    @user_event_attendances = current_user.user_event_attendances.all
    respond_with @user_event_attendances
  end

  def show

  end

end