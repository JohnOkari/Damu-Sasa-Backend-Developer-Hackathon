class SessionsController < ApplicationController

# signup
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            # Generate and return a JWT token for authentication
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: "Invalid username or password" }, status: :unauthorized
        end
    end

# logout
    def destroy
        if session[:user_id]
          session.delete :user_id
          head :no_content
        else
          render json: { error: "You must be logged in to perform this action" }, status: :unauthorized
        end
    end
    
end
  

