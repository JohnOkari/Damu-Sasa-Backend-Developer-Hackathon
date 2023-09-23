class UsersController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only: :create

  # GET /services/1
  def index
    @users = Prescription.all

    render json: @users
  end

  # Signup a user 
  def create
      user = User.create(user_params)
      if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
      else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
  end

  

private

# Only allow a list of trusted parameters through.
  def user_params
    params.permit(:name, :email, :password, :password_cornfirmation)
  end

  def authorize
    @current_user = User.find_by(id: session[:user_id])

    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end
end