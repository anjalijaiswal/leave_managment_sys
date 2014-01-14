class ApplicationController < ActionController::Base
    #before_action :authorize, only: [:show, :edit, :update, :destroy]
	
    def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to users_path , :notice=>"Please Login"
		end
	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
   
   def current_user
    	@user=session[:user_id]
    	User.find(session[:user_id])
    end
end
