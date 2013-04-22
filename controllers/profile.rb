def is_peep?
	username = session[:logged_in]
	error 500 unless username != nil
	peep = Peep.where(username: username).first
	error 500 unless peep != nil

	peep
end


get '/peep/:username' do |username|
	@peep = Peep.where(username: username).first	

	if session[:logged_in] == username then		
		erb :self_profile
	else
		erb :profile
	end
end

post '/peep/update' do 
	peep = is_peep?
	
	short_message = params[:short_message]
	home_mountain = params[:home_mountain]

	if home_mountain != nil then
		home_mountain = home_mountain[0...100]	
	end

	peep.home_mountain = home_mountain
	peep.short_message = short_message

	peep.save

	redirect "/peep/#{peep.username}"
end

post '/peep/location/update' do	
	peep = is_peep?
	

	location = params[:location]	
		
	peep.save


end


get '/js/self_profile.js' do
	coffee :self_profile
end