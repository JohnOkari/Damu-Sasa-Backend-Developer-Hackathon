
    # AppointmentMailer
    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json' # Add this line to require the 'json' library

class AppointmentsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only: :create
   
  # after_create :send_appointment_confirmation_email
  
        

# get current_user from session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  # get a list of all appointments
  def index
    appointments = Appointment.all
    render json: appointments, status: :ok
  end

  # current_user create appointment
  def create
    appointment = current_user.appointments.build(appointment_params)
    if appointment.save
      render json: { status: 'Appointment booked successfully' }, status: :created
    else
      render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  # after_create :send_appointment_confirmation_email

  def available_timeslots
    service_id = params[:service_id]
    date = Date.parse(params[:date]) # You can pass the desired date as a parameter
    # Get the service duration for the selected service
    service = Service.find_by(id: service_id)
    service_duration = service.duration if service
    # Define working hours (adjust as needed)
    working_hours_start = date.to_time + 8.hours
    working_hours_end = date.to_time + 17.hours
    # Find existing appointments for the selected service and date
    existing_appointments = Appointment.where(service_id: service_id, start_time: working_hours_start..working_hours_end)
    # Calculate available timeslots
    available_timeslots = []
    current_time = working_hours_start
    while current_time + service_duration.minutes <= working_hours_end
    # Check if the current timeslot is available (i.e., not already booked)
    if existing_appointments.none? { |appointment| appointment.start_time == current_time }
    available_timeslots << current_time.strftime('%H:%M')
    end
    # Move to the next timeslot
    current_time += service_duration.minutes
    end
    render json: { available_timeslots: available_timeslots }, status: :ok
    end

    # Marks current_user appointment as fulfilled.
    def mark_as_fulfilled
      appointment = current_user.appointments.find(params[:id])
      appointment.update(fulfilled: true)
      render json: { status: 'Appointment marked as fulfilled' }, status: :ok
    end
      
    # Marks current_user appointment as missed. 
    def mark_as_missed
      appointment = current_user.appointments.find(params[:id])
      appointment.update(fulfilled: false)
      render json: { status: 'Appointment marked as missed' }, status: :ok
    end
      
    

  private

  # callback to send an email when a new appointment is created
  def send_appointment_confirmation_email
    url = URI("https://emailapi.netcorecloud.net/v5/mail/send")
  
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Post.new(url)
    request["api_key"] = '3d65cd3b2a075c359e9751336ec51af5'
    request["content-type"] = 'application/json'
  
    # Define the email content as a JSON string
    email_content = {
      from: { email: 'confirmation@pepisandbox.com', name: 'Appointment confirmation' },
      subject: 'Your appointment ticket is ticket : BCN2118050657714',
      content: [
        {
          type: 'html',
          value: "<p>Dear #{@user.name},</p>
                  <p>Your appointment has been successfully booked!</p>
                  <p>Appointment Details:</p>
                  <ul>
                    <li>Date and Time: #{Time.now.strftime('%Y-%m-%d %H:%M')}</li>
                    <li>Service: #{@service.option}</li>
                  </ul>
                  <p>Thank you for choosing our service.</p>"
        }
      ],
      personalizations: [
        {
          to: [{ email: 'johnnokari@gmail.com', name: 'Johnn' }]
        }
      ]
    }
  
    request.body = email_content.to_json # Use to_json to convert the hash to JSON
  
    response = http.request(request)
  
    render json: { message: response.read_body }
  end
  

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:user_id, :service_id, :start_time, :end_time, :status)
  end

  # user authorization for booking an appointment
  def authorize
    render json: { error: 'You must be logged in as a user to book an appointment' }, status: :unauthorized unless current_user
  end

end
