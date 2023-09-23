class PrescriptionsController < ApplicationController


  # get current_user from session
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  # GET /prescriptions
  def index
    @prescriptions = Prescription.all

    render json: @prescriptions
  end


  # POST /prescriptions
  def create
    @prescription = Prescription.new(prescription_params)

    if @prescription.save
      render json: @prescription, status: :created, location: @prescription
    else
      render json: @prescription.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prescription_params
      params.require(:prescription).permit(:patient_id, :doctor_id, :appointment_id, :medication, :instructions)
    end
end
