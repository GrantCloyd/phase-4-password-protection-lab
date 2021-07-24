class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_user_signup


    def create
       # byebug
     user = User.create!(user_parms)
     session[:user_id] = User.last.id
     render json: user
    end

    def show
    user = User.find(session[:user_id])
     render json: user
    rescue ActiveRecord::RecordNotFound
        render json: {error: "User not found"}, status: 401
    end


private 

   def user_parms
    params.permit(:username, :password, :password_confirmation)
   end 

   def handle_invalid_user_signup
     render json: {error: "Invalid user sign-up"}, status: 422
   end

end
