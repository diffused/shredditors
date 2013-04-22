get '/peeps/list' do
	from_record = create_from_record(params[:from].to_i)

	peeps = Peep.all
		.skip(from_record)
		.limit(settings.peeps_limit)
		.without([:password, :validation_pass])
		.to_json(:except => [:password, :validation_pass])
end

get '/peeps/list/:home_mountain' do |home_mountain|	
	from_record = create_from_record(params[:from].to_i)

	Peep
		.where(home_mountain_slug: home_mountain)
		.skip(from_record)
		.limit(settings.peeps_limit)
		.without([:password, :validation_pass])
		.limit(settings.peeps_limit)
		.to_json(:except => [:password, :validation_pass])
end



def create_from_record(from)	
	error 500 unless from >= 0	
	from_record = from * settings.peeps_limit
end

def unique_home_mountains
	
end

get '/js/peeps.js' do
	coffee :peeps
end