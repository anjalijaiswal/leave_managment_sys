class SessionsController < ApplicationController
  #logout_on_timeout true
  def new
 	
  end
  
  def update
 
  end 
  
  def login
 	
 	if @user=User.find_by_name(params[:name]) 
 		 if session.has_key?("user_id")
 		 	redirect_to user_path(@user) , :notice=> "User already login"
 		 else
	 		puts "user logged in"
	 		session[:user_id]=@user.id
	 		@user_time=UserTime.new
	 		@user_time=@user.user_times.create(:login_time=>Time.now,:user_id=>@user.id)
	 		#puts "<<<<<<<<<<<<<<<<<<<<<<<<<#{@user_time.name}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	 		redirect_to @user
 		 end
 	else
 		redirect_to users_url , :notice=>"Invalid User"
  	end
  end

  def logout
  	#puts ">>>>>>>>>>>>>>>>>>>>>>>>>>#{@user_time.login_time}<<<<<<<<<<<<<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  	
  	@user=User.find(params[:id])
  	@user_time=UserTime.find_by(:login_time=>params[:login_time])

  	@user_time.update(:logout_time=>Time.now)
  	
  	@user_time.user_hour=(@user_time.logout_time-@user_time.login_time)/1.minutes
  	a=@user_time.user_hour
  	b=@user.leave
  	puts a
  	puts b

  	case 
  		when b>=3
  			if 5<=a && a<10
  				b=b-0.5
  				puts "working for 5 se jyada n 10 se kam #{@user}"
  				@user.update(:leave=>b)
  				destroy
  			elsif a<5
  				b=b-1
  				puts "working for 5 se kam #{@user}"
  				@user.update(:leave=>b)
  				destroy
  			else
  				destroy
  			end 


  		when 3>b && b>=2
  			if a < 5 
  				puts "working for 5 se kam #{@user}"
  				
  				redirect_to user_path(@user) , :notice=>"You cannot log out as your leave balance is just 2!"
  			
  			elsif 5 <= a && a <10
  				b=b-0.5
  				puts "working for 5 se jyada bt 10 se kam #{@user.leave}"
  				@user.update(:leave=>b)
  				destroy
  			else
  				destroy
  			end

  		when 2>b && b>0
  			if a<10
  				puts "working for 10 se#{@user.leave}"
  				
  				redirect_to user_path(@user) , :notice=>"You cannot log out as your leave balance too low (1)!"
  			else
  				destroy	
 			end 	
  	end
  	

  end

  def destroy
  	
  	#session[:user_id] = nil
	session.delete(:user_id)
	redirect_to users_url, :notice => "Logged out"
  end
end
