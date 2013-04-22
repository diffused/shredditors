get '/register' do
	erb :register
end
	
post '/register' do
	username = params[:username]
	password = params[:password]

	Peep.create(username: username, password: password)

	redirect "/peep/#{username}"
end

get '/login' do	
	erb :login
end

get '/js/login.js' do
	coffee :login
end

get '/logout' do
	session.clear
	#session[:logged_in] = nil
	redirect '/'
end

post '/login' do
	username = params[:username]
	password = params[:password]

	peep_exists = auth_peep(username, password)

	if peep_exists == true then		
		session[:logged_in] = username
		redirect "/peep/#{username}"
	end
	
	flash[:error] = 'nope, try again'
	flash[:username] = username
	redirect '/login'
end