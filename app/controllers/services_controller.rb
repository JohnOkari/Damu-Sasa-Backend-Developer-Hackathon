class ServicesController < ApplicationController


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  
  # GET /services
  def index
    @services = Service.all
    render json: @services
  end

  # POST /services (add specialist, option, and  duration)

  def create
    service = Service.create(service_params)
    if service.save
        render json: service, status: :created
    else
        render json: { error: service.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:specialist, :option, :duration)
    end
end