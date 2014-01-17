namespace :check_logout do
		 task :force_logout => environment do
			 time_range=Time.now.midnight..Time.now.end_of_day
			 @user_times=UserTime.where(:user_times=>{:login_time=>time_range,:logout_time=>nil})
			 @user_times.each{|e|e.logout_time=DateTime.now +1.hour}

		 end
end
		 
			