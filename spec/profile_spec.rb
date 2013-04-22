require 'minitest/spec'
require_relative './test_helper'

include Rack::Test::Methods


describe 'profile' do
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
	
	it 'should map user peep_profile to /peep/:username' do
		get '/peep/diffused' 

		last_response.ok?
		last_response.body.include? 'About you'
	end

	it 'should show self profile page if user logged in and browsed to /peep/:username' do
		do_a_login

		#get '/peep/diffused'

		last_response.body.include? 'self profile'
	end

	it 'post to /peep/update should not allow :home_mountain to be longer than 100 chars' do
		do_a_login

		home_mountain = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbb"

		post '/peep/update', params = { home_mountain: home_mountain }

		peep = Peep.where(username: 'diffused').first
		peep.home_mountain.wont_include 'b'

	end

	it 'post to /peep/update should generate :home_mountain_slug if given a :home_mountain' do
		do_a_login

		home_mountain = 'A Home Mountain'
		post '/peep/update', params = {home_mountain: home_mountain}

		peep = Peep.where(username: 'diffused').first
		peep.home_mountain_slug.must_equal 'a_home_mountain'
	end

	it 'post to /peep/update should truncate :short_message after 140 chars' do
	end

	it 'should error 500 if not logged in and trying to post to /peep/update' do
		post '/peep/update', params = {short_message: 'this short message should not save' }
		last_response.status.must_equal 500
	end

	it 'should save short_message peep details when posting to /peep/update' do		
		do_a_login

		get '/peep/diffused'

		post '/peep/update', params = { short_message: 'a short message'}

		peep = Peep.where(username: 'diffused').first
		peep.short_message.must_equal 'a short message'
	end
	
	it 'should add an entry to Pic upon upload' do
	end
			
	it 'should save a pic upon upload' do
	end

	it 'should not save more than 10 pics' do
	end


	it 'should set the first Pic uploaded as the default_pic' do

	end

	it 'should set the default_pic as the Pic selected with /peep/:username/set_default_pic' do
	end


	it 'should update password when original password is correctly given and posted to /peep/change_password' do
	end

end