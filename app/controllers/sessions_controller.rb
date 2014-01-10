class SessionsController < ApplicationController
  
  def new
 	
  end
  
  def update
  end 
  
  def login
 	
 	if @user=User.find_by_name(params[:name])
 		session[:user_id] = @user.id
 		#@user_time=UserTime.create(:login_time=>Time.now)
 		#@user=@user_time.user.create(:user_id=>@user.id)
 		@user_time=UserTime.new
 		@user_time=@user.user_times.create(:login_time=>Time.now,:user_id=>@user.id)
 		#puts "<<<<<<<<<<<<<<<<<<<<<<<<<#{@user_time.name}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
 		redirect_to @user
 	else
 		redirect_to users_url :alert=>"Invalid User"
  	end
  end

  def logout
  	#puts ">>>>>>>>>>>>>>>>>>>>>>>>>>#{@user_time.login_time}<<<<<<<<<<<<<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  	@user=User.find(params[:id])
  	@user_time=UserTime.find_by_login_time(params[:login_time])

  	@user_time.update(:logout_time=>Time.now)
  	@user_time.user_hour=(@user_time.logout_time-@user_time.login_time)/1.seconds
  	a=@user_time.user_hour/3600
  	b=@user.leave
  	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{@user_time.user_hour}>>>>>>>>>>>>>>>>>>>>>>>>>>"
  	
  	if a <= 10 && b ==1
  		flash.now[:error] = "You cannot logout as your leave balance is too low !"
  		@user_time.update(:logout_time=> nil)
  		redirect_to @user
  	else
  		if a <= 5 && b==3
  			flash.now[:error] = "You cannot log out as your leave balance is just 2!"
  			destroy
  			
  		else
  			if 5 <= a <=10
  				b=b-0.5
  				destroy
  			else
  				if a<=5
  					b=b-1
  					#puts "#{@user.leave}"
  					destroy
  				end
  			end
  		end
  	end	

  end

  def destroy
  	
  	session[:user_id] = nil
	
	redirect_to users_url, :notice => "Logged out"
  end
end
