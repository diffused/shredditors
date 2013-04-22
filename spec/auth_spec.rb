require 'minitest/spec'
require_relative './test_helper'

include Rack::Test::Methods

describe 'auth' do
	def app
    Sinatra::Application
  end

	before do
		clear_cookies
		
		test_data = Setup.new
		test_data.wipe_peeps
		test_data.create_peeps
	end

	def do_a_login
		post '/login', params={ username: 'diffused', password: 'pass' }
		follow_redirect!
	end

	it 'correct login post redirects to /peep/:username' do
		do_a_login

		last_request.path.must_equal '/peep/diffused'		
	end

	it 'incorrect login redirects to /login' do
		post '/login', params={ username: 'diffused', password: 'wrong pass' }
		follow_redirect!		

		last_request.path.must_equal '/login'
	end

	it 'correct login sets session logged_in to logged in username' do
		do_a_login				

		last_request.session[:logged_in].must_equal 'diffused'
	end

	it 'logout sets session logged_in to nil and redirects to /' do
		do_a_login
		
		last_request.session[:logged_in].must_equal 'diffused'		

		get '/logout'
		last_request.session[:logged_in].must_equal nil

	end
end