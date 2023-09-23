class AdminController < ApplicationController
    # Use a before_action to ensure that only authenticated admins can access these actions
    before_action :authenticate_admin


    # get current_user from session
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    # Define the index action for the admin panel
    def index
      # Retrieve the selected date from the URL parameter or default to today
      @selected_date = params[:date] || Time.zone.today
      # Retrieve appointments for the selected date range
      @appointments = Appointment.where(start_time: @selected_date.beginning_of_day..@selected_date.end_of_day)
    end
  
    # Define the mark_as_fulfilled action to mark an appointment as fulfilled
    def mark_as_fulfilled
      appointment = Appointment.find(params[:id])
      appointment.update(status: :fulfilled)
      redirect_to admin_index_path(date: params[:date]), notice: 'Appointment marked as fulfilled'
    end
  
    # Define the mark_as_missed action to mark an appointment as missed
    def mark_as_missed  
      appointment = Appointment.find(params[:id])
      appointment.update(status: :missed)
      redirect_to admin_index_path(date: params[:date]), notice: 'Appointment marked as missed'
    end
  
    private
  
    # Define a private method to authenticate admin users
    def authenticate_admin
      unless current_user.admin?
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
  