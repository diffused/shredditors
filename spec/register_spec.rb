require 'minitest/spec'
require_relative './test_helper'

include Rack::Test::Methods

describe 'register' do
	def app
    Sinatra::Application
  end

  before do
  	test_data = Setup.new
  	test_data.wipe_peeps
  	test_data.create_peeps
  end

	it 'register page is /register' do
		get '/register'

		last_response.status.wont_equal 404
	end
	
	it 'post to /register with username and password creates Peep' do
		post '/register', params = { 
			username: 'test_user',
			password: 'test password'			
		}

		Peep.exists?(
			conditions: {
				username: 'test_user', 
				password: 'test password'
			}
		).must_equal true
	end

	it 'successful register redirects to /peep/:username' do
		post '/register', params = { 
			username: 'test_user',
			password: 'test password'			
		}
		
		follow_redirect!

		last_request.path.must_equal '/peep/test_user'
	end

	it 'new Peep slugifies username' do
		post '/register', params = { 
			username: 'Test User',
			password: 'test password'			
		}

		peep = Peep.where(username: 'Test User').first

		peep.username_slug.must_equal 'test_user'
	end


	it 'new Peep must store password using bcrypt' do
	end

	it 'new Peep must has new random validation_pass' do
	end

	it 'username verification can only run after 1 min as passed since last attempt or first time' do
	end
	


	#it 'username verification marks '
	 

end