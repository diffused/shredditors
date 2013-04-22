require 'minitest/spec'
require_relative './test_helper'

include Rack::Test::Methods

#def app() Shredditors end

describe "peeps" do
	def app
    Sinatra::Application
  end

	before do
		test_data = Setup.new
		test_data.wipe_peeps
		test_data.create_peeps
	end

	it 'peeps_limit is 3' do
		app.settings.peeps_limit.must_equal 3
	end
	
	it 'peeps list returns correct default data' do
		get '/peeps/list'
		response = JSON.parse(last_response.body)
		response.length.must_equal app.settings.peeps_limit
		
		response[0]['username'].must_equal 'diffused'
		response[1]['username'].must_equal 'revert'
		response[2]['username'].must_equal 'James'
	end

	it 'peeps list returns correct from page' do
		get '/peeps/list?from=1'
		response = JSON.parse(last_response.body)		
		#response[0]['username'].must_equal 'James'
		response[0]['username'].must_equal 'name with spaces'
	end

	it 'peeps list handles bad from page' do
		get '/peeps/list?from=999'
		response = JSON.parse(last_response.body)
		response.length.must_equal 0

		get '/peeps/list?from=-999'
		last_response.status.must_equal 500

		#default handling is convert the 'from' value to 0
		get '/peeps/list?from=bad'		
		response = JSON.parse(last_response.body)
		response.length.must_equal app.settings.peeps_limit
		response[0]['username'].must_equal 'diffused'
		response[1]['username'].must_equal 'revert'
		response[2]['username'].must_equal 'James'
	end

	it 'peeps list does not expose peep password or validation_pass' do
		get '/peeps/list'
		response = JSON.parse(last_response.body)		
		
		response[0]['password'].must_be_nil
		response[0]['validation_pass'].must_be_nil
		
		response[1]['password'].must_be_nil
		response[1]['validation_pass'].must_be_nil

		response[2]['password'].must_be_nil
		response[2]['validation_pass'].must_be_nil
	end

	it '/peeps/list/:home_mountain only returns peeps with from that :home_mountain' do
		get '/peeps/list/turoa'
		
		response = JSON.parse(last_response.body)

		response.length.must_equal app.settings.peeps_limit

		response[0]['username'].must_equal 'diffused'
		response[0]['password'].must_be_nil
		response[0]['validation_pass'].must_be_nil

		response[1]['username'].must_equal 'revert'
		response[1]['password'].must_be_nil
		response[1]['validation_pass'].must_be_nil

		response[2]['username'].must_equal 'owen'
		response[2]['password'].must_be_nil
		response[2]['validation_pass'].must_be_nil
	end

	it '/peeps/list/:home_mountain returns correct page' do
		get '/peeps/list/turoa?from=1'
		
		response = JSON.parse(last_response.body)

		response.each do |peep|
			puts peep
		end

		response.length.must_equal 1

		response[0]['username'].must_equal 'oliver'
		response[0]['password'].must_be_nil
		response[0]['validation_pass'].must_be_nil		
		
	end

	it '/peeps/list/:home_mountain invalid or non-existant home_mountain returns nothing' do
		get '/peeps/list/some_made_up_place'
		
		response = JSON.parse(last_response.body)

		response.length.must_equal 0
	end

	it 'unique_home_mountains returns unique list of home mountains' do
		home_mountains = unique_home_mountains
	end

	# it 'thing' do
	# 	peeps = Peep.where(home_mountain_slug: 'turoa')

	# 	peeps.each do |peep|
	# 		puts peep
	# 	end
	# end


end