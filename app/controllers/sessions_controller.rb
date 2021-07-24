class SessionsController < ApplicationController

    def create
     user = User.find_by(username: params[:username])
     if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: 201
     else 
        render json: {error: "Username or password incorrect"}, status: 401
     end
    end

    def destroy
    session.delete(:user_id) 
    head :no_content, status: 204
    end

   def login_params
     params.permit(:username, :password)
   end

end